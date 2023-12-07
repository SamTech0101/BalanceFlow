import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/AppError.dart';

abstract class BankTransactionState{}
class BankTransactionLoading extends BankTransactionState{}
class BankTransactionLoaded extends BankTransactionState{
  final List<TransactionMessage> transactions;

  BankTransactionLoaded({required this.transactions});
}
class BankTransactionError extends BankTransactionState{
  final AppError error;

  BankTransactionError({required this.error});
}