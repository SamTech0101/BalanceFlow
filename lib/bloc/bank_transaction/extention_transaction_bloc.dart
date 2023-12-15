



import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:flutter/widgets.dart';

import '../../model/transaction_message.dart';
import '../../utils/constants.dart';
extension TransactionBlocExtention on TransactionBloc{

  TransactionMessage? parseAtmWithdrawalSms(String sms) {

    final match = atmWithdrawalRegex.firstMatch(sms);
    if (match != null) {
      final amount = double.parse(splitNumberFromString("${match.group(0)}")[0]);

      return TransactionMessage(
          bankName: "",
          amount: amount,
          transactionId: "",
          type: TransactionType.atmWithdrawal,
          date: DateTime.now(),
          description: "SMS",
          id: UniqueKey().toString());
    }
    return null;
  }

  TransactionMessage? parseCreditSms(String sms) {
    final match = debitedAndCreditRegex.firstMatch(sms);
    if (match != null) {
      double amount =  double.parse(splitNumberFromString("${match.group(0)}")[0]);
      return TransactionMessage(
          bankName: "",
          amount: amount,
          transactionId: "",
          type: TransactionType.credit,
          date: DateTime.now(),
          description: "SMS",
          id: UniqueKey().toString());
    }

    return null;
  }


  TransactionMessage? parseDebitSms(String sms) {

      double amount = 0;
    final matchWithBy = debitedAndCreditRegex.firstMatch(sms);
    final matchWithoutBy = debitedRegexWithoutBy.firstMatch(sms);

    if (matchWithoutBy != null) {
      if (double.parse(
          splitNumberFromString("${matchWithoutBy.group(0)}")[0]) != 0) {

        amount = double.parse(
            splitNumberFromString("${matchWithoutBy.group(0)}")[0]);
      }
    }else if (matchWithBy != null) {
      if (double.parse(
          splitNumberFromString("${matchWithBy.group(0)}")[0]) != 0) {

        amount = double.parse(
            splitNumberFromString("${matchWithBy.group(0)}")[0]);
      }
    }
    debugPrint("=======>parseDebitSms  amount ${amount} ");
      return TransactionMessage(
          bankName: "",
        amount: amount,
        transactionId: "",
        type: TransactionType.debit,
        date: DateTime.now(),
        description: "SMS",
        id: UniqueKey().toString());
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