

import 'package:BalanceFlow/model/total_balance.dart';

import '../model/transaction_message.dart';

abstract class TransactionMessageService {
  Future<List<TransactionMessage>> fetchTransactions();
  Future<void> addTransaction(TransactionMessage message);
  Future<void> deleteTransactionMessage(String messageId);
  Future<void> updateTransaction(String messageId, TransactionMessage updatedTransaction);
  Future<TotalBalanceModel> calculateTotalBalance();
}