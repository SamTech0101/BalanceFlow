// Define regex patterns for different SMS types



// final RegExp debitedRegex = RegExp(
//   r'Dear (\S+) user (.*?) debited by (\S+) on date (.*?) trf to (.*?) Refno (\d+)',
// );
// const String _patternWithRS = r'debited by Rs\.\d+(\.\d{2})?';
const String pattern = r'by (Rs\.\s*)?\d+(\.\d{1,2})?';
const String _patternWithoutRs = r'Rs\.\d+(\.\d{2})?';

final RegExp debitedRegex = RegExp(pattern);
final RegExp debitedRegexWithoutRs = RegExp(pattern);
final  atmWithdrawalRegex = RegExp(pattern);

final RegExp creditSmsRegex = RegExp(
  r'Dear (\S+) (\S+) User, ur (.*?) credited by (\S+) on (\S+) by \(Ref (\S+)\)',
);


//string
 const String openSansFont = "OpenSans";
 const String hiveThemeStateKey = "isDarkTheme";
 const String hiveThemeKey = "Theme";
 const String hiveTransactionKey = "TransactionKey";
 const String hiveSMSKey = "SMSKey";
 const String debitTitle = "Debit";
 const String creditTitle = "credit";
 const String atmTitle = "ATM";
 const String withdrawnTitle = "withdrawn";

 //transactions Screen
 const String transactions = "Transactions";

 //Success
const String addTransactionSuccessTitle = "Your transactions update";
const String deleteTransactionSuccessTitle = "Your transaction deleted";


 //Errors
const String storageError = "Failed to access storage. Please try again.";
const String networkError = "Network error occurred. Please try again";
const String unexpectedError = "An unexpected error occurred. Please try again later.";
const String generalError = "something went wrong";
const String parseSMSError = "Received SMS does not match expected formats.";


//int
const int hiveTypeId0 = 0;



