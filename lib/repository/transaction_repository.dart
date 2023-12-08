import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/services/transactions_serviece.dart';

class TransactionMessageRepository implements TransactionMessageService{
  @override
  Future<void> addTransaction(TransactionMessage message) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransactionMessage(String messageId) {
    // TODO: implement deleteTransactionMessage
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionMessage>> fetchTransactions() {
    // TODO: implement fetchTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(String messageId, TransactionMessage updatedTransaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }

}