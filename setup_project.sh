#!/bin/bash

read -p "app Name (my_ticket_app): " NEW_NAME
read -p "Your company domain (amin): " NEW_DOMAIN
read -p "App description: " NEW_DESCRIPTION
NEW_BUNDLE="com.$NEW_DOMAIN.${NEW_NAME,,}"
TARGETS="android,ios,web"
OLD_NAME=$(grep "^name: " pubspec.yaml | sed 's/name: //')

# check if the script is run in the root directory of a Flutter project
if [ ! -f "pubspec.yaml" ]; then
    echo "this script must be run in the root directory of a Flutter project."
    exit 1
fi

# install rename tool if not already installed
if ! command -v rename &> /dev/null
then
    echo "🔍 rename tool not found, installing..."
    flutter pub global activate rename
fi

# check if rename is in PATH, if not, add it temporarily
if [[ ":$PATH:" != *":$HOME/.pub-cache/bin:"* ]]; then
    echo "🔧 rename tool not found in PATH, adding temporarily..."
    export PATH="$PATH:$HOME/.pub-cache/bin"
fi

# change to the parent directory of the current script
CURRENT_DIR=$(basename "$(pwd)")
if [ "$CURRENT_DIR" != "$NEW_NAME" ]; then
    echo "📁 Changing project folder name from $CURRENT_DIR to $NEW_NAME..."
    mv "../$CURRENT_DIR" "../$NEW_NAME"
    cd "../$NEW_NAME" || exit 1
    echo "📁 Moved to new directory: $(pwd)"
fi

# run rename tool to change app name and bundle ID
echo " change AppName to: $NEW_NAME"
rename setAppName --value "$NEW_NAME" --targets $TARGETS

echo " change BundleId to: $NEW_BUNDLE"
rename setBundleId --value "$NEW_BUNDLE" --targets $TARGETS

# ------------- replace pubspec.yaml -------------
echo "📝 replace name in pubspec.yaml..."
sed -i "s/^name: .*/name: $NEW_NAME/" pubspec.yaml
echo "📝 replace description in pubspec.yaml..."
sed -i "s/^description: .*/description: $NEW_DESCRIPTION/" pubspec.yaml

echo " replace from package:$OLD_NAME to package:$NEW_NAME"
grep -rl "package:$OLD_NAME" lib/ | xargs sed -i "s/package:$OLD_NAME/package:$NEW_NAME/g"

GRADLE_FILE="android/app/build.gradle"
if [ ! -f "$GRADLE_FILE" ]; then
    exit 1
fi
if ! grep -q "^android {" "$GRADLE_FILE"; then
    exit 1
fi
sed -i "/^[[:space:]]*namespace[[:space:]]*=.*$/d" "$GRADLE_FILE"
sed -i "/^android {/a \    namespace = \"$NEW_BUNDLE\"" "$GRADLE_FILE"

# clean and get dependencies
echo "🧹 clean flutter..."
flutter clean
flutter pub get
flutter pub outdated

echo " app Name: $NEW_NAME"
echo " Bundle ID: $NEW_BUNDLE"
echo " Description: $NEW_DESCRIPTION"
echo " targets: $TARGETS"

echo "🔄 Resetting Git repository..."

rm -rf .git
git init
git add .
git commit -m "Initial commit after setup"
code .

echo "🗑️ Removing setup_project.sh..."
SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
(
  sleep 1
  rm -- "$SCRIPT_PATH"
) & disown
echo "✅ Project setup completed successfully!"