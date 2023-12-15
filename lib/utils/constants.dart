// Define regex patterns for different SMS types
const String _pattern = r'by (\S+)';
const String _patternWithoutBy = r'Rs\.\d+(\.\d{2})?';

final RegExp debitedAndCreditRegex = RegExp(_pattern);
final RegExp debitedRegexWithoutBy = RegExp(_patternWithoutBy);
final  atmWithdrawalRegex = RegExp(_patternWithoutBy);




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
const String dailyTitle = "daily";
const String weeklyTitle = "weekly";
const String monthlyTitle = "monthly";

//transactions Screen
const String transactionsTitle = "Transactions";

//Success
const String addTransactionSuccessTitle = "Your transactions update";
const String deleteTransactionSuccessTitle = "Your transaction deleted";

//Errors
const String storageError = "Failed to access storage. Please try again.";
const String networkError = "Network error occurred. Please try again";
const String unexpectedError =
    "An unexpected error occurred. Please try again later.";
const String generalError = "something went wrong";
const String parseSMSError = "Received SMS does not match expected formats.";


//int
const int hiveTypeId0 = 0;



