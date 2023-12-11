import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/AppError.dart';

abstract class TransactionState{}
class TransactionInitial extends TransactionState{}
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