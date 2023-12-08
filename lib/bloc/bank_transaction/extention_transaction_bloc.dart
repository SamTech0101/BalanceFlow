
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';

import '../../model/transaction_message.dart';
import '../../utils/AppError.dart';
import '../../utils/constants.dart';
extension TransactionBlocExtention on TransactionBloc{

  TransactionMessage _parseAtmWithdrawalSms(String sms) {
    final match = atmWithdrawalRegex.firstMatch(sms);
    if (match != null) {
      final bankName = match.group(1)!;
      final transactionId = match.group(7)!;
      final amount = double.parse(match.group(2)!);
      final date = _parseDate(match.group(6)!);

      return TransactionMessage(
        bankName: bankName,
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
      final date = _parseDate(match.group(5)!);
      final transactionId = match.group(6)!;


      return TransactionMessage(
        bankName: "$bankName1 $bankName2",
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
      final date = _parseDate(match.group(4)!);
      final recipient = match.group(5)!;

      return TransactionMessage(
          bankName: bankName,
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