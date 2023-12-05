# Flutter Project: BalanceFlow

This document outlines the directory structure of the `BalanceFlow` Flutter application. The structure is designed to promote BloC architecture, separation of concerns, and ease of navigation.

## Directory Structure Overview

Below is the hierarchy and description of the key directories and files in the project:

BalanceFlow
├── android                       # Android platform-specific configuration files
├── ios                           # iOS platform-specific configuration files
├── lib
│   ├── bloc                      # Business Logic Components (BLoC)
│   │   ├── bank_transaction      # Handles bank transactions
│   │   │   ├── bank_transaction_bloc.dart    # BLoC for bank transactions
│   │   │   ├── bank_transaction_event.dart   # Events for bank transaction BLoC
│   │   │   └── bank_transaction_state.dart   # States for bank transaction BLoC
│   │   └── theme                 # Theme management
│   │       ├── theme_bloc.dart               # BLoC for app theming
│   │       ├── theme_event.dart              # Events for theme BLoC
│   │       └── theme_state.dart              # States for theme BLoC
│   ├── model                     # Data models
│   │   ├── transaction_message.dart          # Transaction message model
│   │   └── transaction_type.dart             # Transaction type enum
│   ├── repository                # Repositories
│   │   └── sms_repository.dart               # SMS data handling
│   ├── data_provider             # Data providers
│   │   └── sms_data_provider.dart            # Provider for SMS data
│   ├── services                  # Services
│   │   └── telephony_service.dart            # Service for telephony operations
│   ├── storage                   # Local storage
│   │   └── hive_storage.dart                 # Hive database storage
│   ├── ui                        # User Interface
│   │   ├── screens               # Screen widgets
│   │   │   ├── home_screen.dart              # Home screen
│   │   │   └── transaction_list_screen.dart  # Transaction list screen
│   │   └── widgets               # Reusable UI components
│   │       └── custom_widget.dart            # Custom widget example
│   ├── utils                     # Utility functions and classes
│   │   └── theme_utils.dart                  # Utilities for theming
│   ├── core                      # Core functionalities
│   │   └── locator.dart                      # Service locator using getIt
│   └── main.dart                 # Main entry point of the application
├── test                          # Test files
└── pubspec.yaml                  # Project configuration and dependencies


## Description

- **/android & /ios:** Contains platform-specific configurations and native code.
- **/lib:** The main directory for Dart code, organized into several subdirectories for clarity.
- **/bloc:** Contains the logic for state management using the BLoC pattern.
- **/model:** Holds data model definitions.
- **/repository:** Manages data interactions and abstracts the data layer.
- **/data_provider:** Direct interaction with data sources.
- **/services:** Business logic and platform services like telephony.
- **/storage:** Local persistence using Hive.
- **/ui:** User interface components, split into screens and reusable widgets.
- **/utils:** Shared utility functions and classes.
- **/core:** Core functionalities like dependency injection setup.
- **/test:** Contains unit and widget tests.
- **pubspec.yaml:** Defines the project's dependencies and settings.

This structured approach aids in maintaining a clean and scalable codebase.
