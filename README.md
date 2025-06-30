# Flutter Base Template

A modular, production-ready Flutter starter template for rapid app development. Pre-configured with state management, networking, navigation, theming, localization, and an automated setup script.

**Description**: Flutter Base Template offers a scalable foundation with Provider, Dio, GoRouter, theming, localization, and a setup script for app name, Bundle ID, and description. Includes tests and CI/CD. MIT License.

## Features

- **Modular Architecture**: Organized with `lib/core` and `lib/features`.
- **State Management**: Provider for lightweight, scalable state handling.
- **Networking**: Dio for efficient API calls with error management.
- **Navigation**: GoRouter for type-safe routing.
- **Theming**: Light/dark themes with customizable styles.
- **Localization**: Multi-language support via `flutter_localizations`.
- **Setup Script**: Automates app renaming and configuration for Android, iOS, and web.
- **Testing**: Sample unit and widget tests.
- **CI/CD**: GitHub Actions for automated testing and builds.

## Prerequisites

- Flutter SDK (stable channel)
- Dart
- `rename` package (installed automatically by script)

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/Amin-Aghili/flutter_base_template.git
   ```
2. Navigate to the project directory:
   ```bash
   cd flutter_base_template
   ```
3. Make the setup script executable:
   ```bash
   chmod +x scripts/setup_project.sh
   ```
4. Run the setup script and follow prompts for app name, company domain, and description:
   ```bash
   ./scripts/setup_project.sh
   ```
5. Start developing your app:
   ```bash
   flutter run
   ```
   Adding a New Language
   Create a file named app\_[language_code].arb (e.g., app_tr.arb for Turkish) in the l10n folder.

To add support for a new language in the app, follow these steps:

1. Create a new ARB file:
   - Create a file named app\_[language_code].arb (e.g., app_tr.arb for Turkish) in the l10n folder.
   - Add the translated strings in the JSON-like format. Example:
     ```bash
     {
       "helloWorld": "Merhaba Dünya!",
       "search": "Ara",
       "@helloWorld": {
            "description": "Yeni başlayan programcıların geleneksel selamlaması"
        }
     }
     ```
2. Run the localization generator:
   - Execute the following command to generate the necessary Dart files for localization:
     ```bash
     flutter gen-l10n
     ```
3. Go to lib/screens/main/components/lanuge_selector.dart add new lang Items DropdownMenuTtem :
   ```bash
   items: const [
        DropdownMenuItem(
          value: 'en',
          child: Text('English'),
        ),
   ```
