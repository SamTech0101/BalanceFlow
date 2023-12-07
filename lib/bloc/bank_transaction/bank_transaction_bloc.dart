import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/AppError.dart';
import 'package:BalanceFlow/utils/constants.dart';
import 'package:bloc/bloc.dart';

import 'bank_transaction_state.dart';

class BankTransactionBloc extends Bloc<BankTransactionEvent, BankTransactionState>{
  BankTransactionBloc() : super(BankTransactionLoading()){
    on<LoadBankTransactions>((event, emit) {
      try{
        emit(BankTransactionLoaded(transactions: [TransactionMessage(bankName : "Mellat", amount: 29.3, transactionId: "324", type: TransactionType.atmWithdrawal, account: "AS/123", date: DateTime(2023),),TransactionMessage(amount: 222349.3, transactionId: "23423424234", type: TransactionType.credit, account: "AS/234234", date: DateTime(2023))]));
      }catch(_){
        emit(BankTransactionError(error: AppError.customError(generalError)));
      }
    });
  }


}