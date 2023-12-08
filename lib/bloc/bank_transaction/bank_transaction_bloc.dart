import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/core/service_locator.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/AppError.dart';
import 'package:BalanceFlow/utils/constants.dart';
import 'package:bloc/bloc.dart';

import '../../repository/transaction_repository.dart';
import '../../utils/general.dart';
import 'bank_transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState>{
  final TransactionsRepository _repository;
  TransactionBloc() : _repository = locator<TransactionsRepository>(), super(TransactionLoading()){
    on<LoadBankTransactions>((event, emit) {
      try{
        emit(FetchTransactions(transactions: [
          TransactionMessage(bankName : "Panama", amount: 29.3, transactionId: "324", type: TransactionType.atmWithdrawal,  date: DateTime(2023),),
          TransactionMessage(amount: 222349.3, transactionId: "23423424234", type: TransactionType.credit,  date: DateTime(2023), bankName: 'HTC')]));
      }catch(_){
        emit(TransactionError(error: AppError.customError(generalError)));
      }
    });
  }


}
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