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
   git clone https://github.com/your-username/flutter-base-template.git
   ```
2. Navigate to the project directory:
   ```bash
   cd flutter-base-template
   ```
4. Make the setup script executable:
  ```bash
  chmod +x scripts/setup_project.sh
  ```
6. Run the setup script and follow prompts for app name, company domain, and description:
   ```bash
   ./scripts/setup_project.sh
   ```
8. Start developing your app:
   ```bash
   flutter run
   ```
