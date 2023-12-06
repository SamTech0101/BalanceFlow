# Flutter Project: BalanceFlow

This document outlines the directory structure of the `BalanceFlow` Flutter application. The structure is designed to promote BloC architecture, separation of concerns, and ease of navigation.

## Project Layout

Below is the hierarchy and description of the key directories and files in the project:

```plaintext
BalanceFlow
├── android                 
├── ios                      
├── lib
│   ├── bloc                    
│   │   ├── bank_transaction    
│   │   │   ├── bank_transaction_bloc.dart    
│   │   │   ├── bank_transaction_event.dart   
│   │   │   └── bank_transaction_state.dart  
│   │   └── theme               
│   │       ├── theme_bloc.dart               
│   │       ├── theme_event.dart             
│   │       └── theme_state.dart              
│   ├── model                 
│   │   ├── transaction_message.dart          
│   │   └── transaction_type.dart            
│   ├── repository             
│   │   └── sms_repository.dart               
│   ├── data_provider          
│   │   └── sms_data_provider.dart          
│   ├── services                
│   │   └── telephony_service.dart           
│   ├── storage                
│   │   └── hive_storage.dart               
│   ├── ui                      
│   │   ├── screens             
│   │   │   ├── home_screen.dart              
│   │   │   └── transaction_list_screen.dart 
│   │   └── widgets             
│   │       └── custom_widget.dart            
│   ├── utils                  
│   │   └── theme_utils.dart                 
│   └── core                    
│       └── locator.dart                      
├── main.dart                  
├── test                       
└── pubspec.yaml             
```
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


=======
# balanceflow

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
