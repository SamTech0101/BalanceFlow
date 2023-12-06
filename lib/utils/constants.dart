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