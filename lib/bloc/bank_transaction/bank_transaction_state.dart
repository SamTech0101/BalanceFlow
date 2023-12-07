import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/AppError.dart';

abstract class BankTransactionState{}
class BankTransactionLoading extends BankTransactionState{}
class BankTransactionLoaded extends BankTransactionState{
  final TransactionMessage transactionMessage;

  BankTransactionLoaded({required this.transactionMessage});
}
class BankTransactionError extends BankTransactionState{
  final AppError error;

  BankTransactionError({required this.error});
}