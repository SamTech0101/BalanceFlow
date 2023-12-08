import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/services/transactions_serviece.dart';
import 'package:BalanceFlow/storage/hive_storage.dart';

class TransactionsRepository implements TransactionMessageService{
  final LocalTransactions _localTransactions;

  TransactionsRepository(this._localTransactions);
  @override
  Future<void> addTransaction(TransactionMessage message)async {
    try{

    }catch(_){

    }
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