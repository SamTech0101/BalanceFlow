import 'package:BalanceFlow/model/total_balance.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/AppError.dart';

abstract class TransactionState{}
class FetchTotalBalance extends TransactionState{
  final TotalBalanceModel totalBalanceModel;

  FetchTotalBalance({required this.totalBalanceModel});
}
class TransactionInitial extends TransactionState{}
class FetchGraph extends TransactionState{}
class TransactionLoading extends TransactionState{}
class FetchTransactions extends TransactionState{
  final List<TransactionMessage> transactions;

  FetchTransactions({required this.transactions});
}
class TransactionOperationSuccess extends TransactionState {
  final String message;
  final List<TransactionMessage>? transactions ;

  TransactionOperationSuccess({required this.message,this.transactions});
}

class TransactionError extends TransactionState{
  final AppError error;

  TransactionError({required this.error});
}