# BalanceFlow

This application automatically reads the messages of banks in India and displays a pie chart and a list of bank transactions, allowing you to manage your income.
‌Bank SMS examples : 
 
**Cedit SMS Bank:** ![Credit SMS Bank](https://github.com/SamTech0101/BalanceFlow/blob/main/images/credit.png)

**Debit SMS Bank:**![Debit SMS Bank](https://github.com/SamTech0101/BalanceFlow/blob/main/images/debit.png)
 
**withdraw ATM SMS Bank:**![ATM SMS Bank](https://github.com/SamTech0101/BalanceFlow/blob/main/images/withdraw.png)


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
│   │   │   └── extention_transaction_bloc.dart  
│   │   └── theme               
│   │       ├── theme_bloc.dart               
│   │       ├── theme_event.dart             
│   │       └── theme_state.dart              
│   ├── model                 
│   │   ├── transaction_message.dart          
│   │   └── transaction_message.g.dart            
│   │   └── transaction_type_adapter.dart            
│   │   └── total_balance.dart            
│   │   └── time_period.dart           
│   ├── repository             
│   │   └── transaction_repository.dart                      
│   ├── services                
│   │   └── transactions_service.dart           
│   ├── storage                
│   │   └── hive_storage.dart               
│   ├── ui                      
│   │   ├── screens                         
│   │   │   ├── error_screen.dart              
│   │   │   └── transactions_screen.dart 
│   │   └── widgets             
│   │       └── tadd_transaction_dialog.dart            
│   │       └── pie_chart.dart           
│   │       └── pie_chart_indicator.dart           
│   │       └── snack_bar_error.dart           
│   │       └── TimePeriod.dart            
│   │       └── total_balance.dart           
│   │       └── transaction_graph.dart            
│   ├── utils                  
│   │   └── AppError.dart                 
│   │   └── colors.dart                 
│   │   └── constant.dart                 
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

This is a description of `BalanceFlow`. It is released under the terms of
the [MIT License](LICENSE).

This document outlines the directory structure of the `BalanceFlow` Flutter application. The
structure is designed to promote BloC architecture, separation of concerns, and ease of navigation.

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
