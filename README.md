# Money Expense App

Money Expense is a Flutter application designed to help users track their expenses. This document provides an overview of the project, setup instructions, and basic usage.

## Table of Contents

- [HackerRank](#hackerrank)
- [Apps](#apps)
- [Features](#features)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Running the App](#running-the-app)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## HackerRank
[HackerRank](https://www.hackerrank.com/certificates/470c8aa95747)
[problem_solving_basic certificate.pdf](https://github.com/user-attachments/files/16325043/problem_solving_basic.certificate.pdf)

## Apps
[Apps](app-release.apk)

## Features

- Track daily expenses
- Categorize expenses
- Visualize expense data

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- An IDE such as [VSCode](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/VamosIna/moneyexpense.git
    cd moneyexpense
    ```

2. Install dependencies:

    ```bash
    flutter pub get
    ```

### Running the App

1. Connect your device or start an emulator.
2. Run the app:

    ```bash
    flutter run
    ```

## Project Structure

moneyexpense/
├── android/ # Android-specific configuration
├── ios/ # iOS-specific configuration
├── lib/ # Main Dart code
├── main.dart # Entry point of the application
├── models/ # Data models
├── screens/ # UI screens
├── widgets/ # Reusable widgets
└── utils/ # Utility functions
├── test/ # Unit and widget tests
├── assets/ # Assets like fonts and icons
│ ├── fonts/ # Custom fonts
│ ├── icons/ # Application icons
├── pubspec.yaml # Flutter and Dart dependencies
└── README.md # Project documentation


## Dependencies

The `pubspec.yaml` file includes the following dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^7.0.0  # State management
  sqflite: ^2.0.0+3     # SQLite database
  path_provider: ^2.0.2 # Path provider for storing files
  path: ^1.8.0          # Path manipulation
  intl: ^0.17.0         # Internationalization and localization
  cupertino_icons: ^1.0.2  # iOS style icons
fonts:
  - family: SourceSansPro
    fonts:
      - asset: assets/fonts/SourceSans3-Regular.ttf
      - asset: assets/fonts/SourceSans3-Bold.ttf
        weight: 700
      - asset: assets/fonts/SourceSans3-Italic.ttf
        style: italic
assets:
  - assets/icons/
