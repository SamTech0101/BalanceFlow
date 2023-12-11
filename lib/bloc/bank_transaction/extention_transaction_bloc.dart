
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../model/transaction_message.dart';
import '../../utils/constants.dart';
extension TransactionBlocExtention on TransactionBloc{

  TransactionMessage? parseAtmWithdrawalSms(String sms) {

    final match = atmWithdrawalRegex.firstMatch(sms);
    if (match != null) {
      debugPrint("=============>> parseAtmWithdrawalSms is match ${match}");
      final convertedAmount = match.group(0)!.split("Rs.")[1];
      final amount = double.parse(convertedAmount);

      return TransactionMessage(
          bankName: "",
          amount: amount,
          transactionId: "",
          type: TransactionType.atmWithdrawal,
          date: DateTime.now(),
          description: "SMS"
      );
    }
    return null;
  }

  TransactionMessage? parseCreditSms(String sms) {
    final match = creditSmsRegex.firstMatch(sms);
    if (match != null) {

      double amount =  double.parse(splitNumberFromString("${match.group(4)}")[0]);


      return TransactionMessage(
        bankName: "",
        amount: amount ,
        transactionId: "",
        type: TransactionType.credit,
        date: DateTime.now(),
        description: "SMS"
      );
    }

    return null;
  }


  TransactionMessage? parseDebitSms(String sms) {

    final matchWithBy = debitedAndCreditRegex.firstMatch(sms);
    final matchWithoutBy = debitedRegexWithoutBy.firstMatch(sms);
    debugPrint("=======>>> parseDebitSms ");

    if (matchWithBy != null) {
      var  convertedAmount = "";
      if (matchWithBy.group(0)!.contains("Rs")){
        convertedAmount = matchWithBy.group(0)!.split("by Rs.")[1];
      }else {
        convertedAmount = matchWithBy.group(0)!.split("by ")[1];
      }

      final amount = double.parse(convertedAmount);

      return TransactionMessage(
          bankName: "",
          amount: amount,
          transactionId: "",
          type: TransactionType.debit,
          date: DateTime.now(),
          description: "SMS"
      );
    }else if (matchWithoutBy != null) {
      var  convertedAmount = "";
      if (matchWithoutBy.group(0)!.contains("Rs")){
        convertedAmount = matchWithoutBy.group(0)!.split("Rs.")[1];
      }else {
        convertedAmount = matchWithoutBy.group(0)!;
      }

      final amount = double.parse(convertedAmount);

      return TransactionMessage(
          bankName: "",
          amount: amount,
          transactionId: "",
          type: TransactionType.debit,
          date: DateTime.now(),
          description: "SMS"
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

}