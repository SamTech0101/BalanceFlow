import 'package:BalanceFlow/utils/AppError.dart';

import '../model/transaction_message.dart';
import '../utils/constants.dart';
import '../utils/general.dart';

class SmsDataProvider{

  TransactionMessage _parseAtmWithdrawalSms(String sms) {
    final match = atmWithdrawalRegex.firstMatch(sms);
    if (match != null) {

      final bankName = match.group(1)!;
      final transactionId = match.group(7)!;
      final amount = double.parse(match.group(2)!);
      final date = parseDate(match.group(6)!);

      return TransactionMessage(
        bankName: bankName ,
        amount: amount,
        transactionId: transactionId,
        type: TransactionType.atmWithdrawal,
        date: date,
      );
    } else {
      throw AppError.customError(parseSMSError);
    }
  }
  TransactionMessage _parseCreditSms(String sms) {
    final match = creditSmsRegex.firstMatch(sms);
    if (match != null) {
      final bankName1 = match.group(1)!;
      final bankName2 = match.group(2)!;
      final amount = double.parse(match.group(2)!);
      final date = parseDate(match.group(5)!);
      final transactionId = match.group(6)!;


      return TransactionMessage(
        bankName: "$bankName1 $bankName2" ,
        amount: amount,
        transactionId: transactionId,
        type: TransactionType.credit,
        date: date,
      );
    } else {
      throw AppError.customError(parseSMSError);
    }
  }
  TransactionMessage _parseDebitSms(String sms) {
    final match = debitedRegex.firstMatch(sms);
    if (match != null) {
      final bankName = match.group(1)!;
      final transactionId = match.group(6)!;
      final amount = double.parse(match.group(3)!);
      final date = parseDate(match.group(4)!);
      final recipient =match.group(5)!;

      return TransactionMessage(
        bankName: bankName ,
        amount: amount,
        transactionId: transactionId,
        type: TransactionType.atmWithdrawal,
        date: date,
        description: recipient
      );
    } else {
      throw AppError.customError(parseSMSError);
    }

  }

}