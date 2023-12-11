
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/repository/transaction_repository.dart';
import 'package:flutter/foundation.dart';

import '../../model/transaction_message.dart';
import '../../utils/constants.dart';
extension TransactionBlocExtention on TransactionBloc{

  TransactionMessage? parseAtmWithdrawalSms(String sms) {

    final match = atmWithdrawalRegex.firstMatch(sms);
    if (match != null) {
      debugPrint("=============>> parseAtmWithdrawalSms is match ${match}");

      final bankName = match.group(1)!;
      final transactionId = match.group(7)!;
      final amount = double.parse(match.group(2)!);
      final date = _parseDate(match.group(6)!);
      debugPrint("<<=============>> parseAtmWithdrawalSms  ${bankName}<<<${transactionId}<<<${amount}<<<${date}");

      return TransactionMessage(
        bankName: bankName,
        amount: amount,
        transactionId: transactionId,
        type: TransactionType.atmWithdrawal,
        date: date,
      );
    }
    return null;
  }

  TransactionMessage? parseCreditSms(String sms) {
    final match = creditSmsRegex.firstMatch(sms);
    if (match != null) {
      // debugPrint("=============>> parseCreditSms is match ${match.groupCount}");
      // debugPrint("=============>> parseCreditSms account ${match.group(3)}");
      // debugPrint("=============>> parseCreditSms amount ${match.group(4)}");
      // debugPrint("=============>> parseCreditSms date ${match.group(5)}");
      // debugPrint("=============>> parseCreditSms transactionID ${match.group(6)}");

      final bankName1 = match.group(1)!;
      final bankName2 = match.group(2)!;
      double amount =  double.parse(splitNumberFromString("${match.group(4)}")[0]);
      final date = _parseDate(match.group(5)!);
      final transactionId = match.group(6)!;

      // debugPrint("<<=============>> parseCreditSms  ${bankName1}<<<${bankName2}<<<${amount}<<<${date}<<<${transactionId}");

      return TransactionMessage(
        bankName: "$bankName1 $bankName2",
        amount: amount ,
        transactionId: transactionId,
        type: TransactionType.credit,
        date: date,
      );
    }

    return null;
  }


  TransactionMessage? parseDebitSms(String sms) {
    final match = debitedRegex.firstMatch(sms);

    if (match != null) {
      debugPrint("<<=============>> parseDebitSms");
      final bankName = match.group(1)!;
      final transactionId = match.group(6)!;
      final amount = double.parse(match.group(3)!);
      final date = _parseDate(match.group(4)!);
      final recipient = match.group(5)!;
      debugPrint("<<=============>>  parseDebitSms ${bankName}<<<${transactionId}<<<${amount}<<<${date}<<<${recipient}");

      return TransactionMessage(
          bankName: bankName,
          amount: amount,
          transactionId: transactionId,
          type: TransactionType.atmWithdrawal,
          date: date,
          description: recipient
      );
    }
    return null;
  }
  List<String> splitNumberFromString(String input) {
    RegExp regExp = RegExp(r'(\d+|\D+)');
    var matches = regExp.allMatches(input).map((m) => m.group(0) ?? "").toList();
    // Check if the first element is not a number, and if so, swap the elements
    if (matches.isNotEmpty && !RegExp(r'^\d+$').hasMatch(matches[0])) {
      for (var i = 1; i < matches.length; i++) {
        if (RegExp(r'^\d+$').hasMatch(matches[i])) {
          var temp = matches[0];
          matches[0] = matches[i];
          matches[i] = temp;
          break;
        }
      }
    }

    return matches;
  }
  DateTime _parseDate(String dateString) {
    // Define a map to convert month abbreviations to month numbers
    const monthNumbers = {
      'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04', 'May': '05', 'Jun': '06',
      'Jul': '07', 'Aug': '08', 'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12',
    };

    // Extract the day, month abbreviation, and year from the dateString
    final day = dateString.substring(0, 2);
    final monthAbbr = dateString.substring(2, 5);
    final year = dateString.substring(5);

    // Convert the month abbreviation to a number
    final month = monthNumbers[monthAbbr];

    // Construct the date in YYYY-MM-DD format
    final formattedDate = '20$year-$month-$day';

    // Parse the formatted date string into a DateTime object
    return DateTime.parse(formattedDate);
  }
}