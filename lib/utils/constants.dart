// Define regex patterns for different SMS types

final  atmWithdrawalRegex = RegExp(r'Dear (\S+) Customer, (.*?) withdrawn at (.*?) ATM (.*?) from (.*?) on (.*?) Transaction Number (.*?). Available Balance (\S+)', caseSensitive: false);

final RegExp debitedRegex = RegExp(
  r'Dear (\S+) user (.*?) debited by (\S+) on date (.*?) trf to (.*?) Refno (\d+)',
);
final RegExp creditSmsRegex = RegExp(
  r'Dear (\S+) (\S+) User, ur (.*?) credited by (\S+) on (\S+) by \(Ref (\S+)\)',
);


//string
 const String openSansFont = "OpenSans";
 const String hiveThemeStateKey = "isDarkTheme";
 const String hiveThemeKey = "Theme";
 const String hiveTransactionKey = "isDarkTheme";

 //transactions Screen
 const String transactions = "Transactions";

 //Errors
const String storageError = "Failed to access storage. Please try again.";
const String networkError = "Network error occurred. Please try again";
const String unexpectedError = "An unexpected error occurred. Please try again later.";
const String generalError = "something went wrong";
const String parseSMSError = "'Could not parse SMS'";


//int
const int hiveTypeId0 = 0;



