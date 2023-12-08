# BalanceFlow

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
│   │   └── transaction_message.g.dart            
│   ├── repository             
│   │   └── transaction_repository.dart                      
│   ├── services                
│   │   └── transactions_service.dart           
│   ├── storage                
│   │   └── hive_storage.dart               
│   ├── ui                      
│   │   ├── screens             
│   │   │   ├── home_screen.dart              
│   │   │   ├── error_screen.dart              
│   │   │   └── transactions_screen.dart 
│   │   └── widgets             
│   │       └── transaction_card.dart            
│   ├── utils                  
│   │   └── AppError.dart                 
│   │   └── Constants.dart                 
│   │   └── general.dart                 
│   │   └── theme_utils.dart                 
│   └── core                    
│       └── service_locator.dart                      
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
- **/services:** Business logic and platform services .
- **/storage:** Local persistence using Hive.
- **/ui:** User interface components, split into screens and reusable widgets.
- **/utils:** Shared utility functions and classes.
- **/core:** Core functionalities like dependency injection setup.
- **/test:** Contains unit and widget tests.
- **pubspec.yaml:** Defines the project's dependencies and settings.


This structured approach aids in maintaining a clean and scalable codebase.


