import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/services/transactions_serviece.dart';
import 'package:BalanceFlow/storage/hive_storage.dart';
import 'package:BalanceFlow/utils/AppError.dart';

class TransactionsRepository implements TransactionMessageService{
  final LocalTransactions _localTransactions;

  TransactionsRepository(this._localTransactions);
  @override
  Future<void> addTransaction(TransactionMessage message) async {
    try{
     await  _localTransactions.addTransaction(message);
    }catch(_){
      throw AppError.exception(Exception());

    }
  }

  @override
  Future<void> deleteTransactionMessage(String messageId) async{
    try{
      await _localTransactions.deleteTransactionMessage(messageId);
    }catch(_){
      throw AppError.exception(Exception());

    }
  }

  @override
  Future<List<TransactionMessage>> fetchTransactions() async{
    try{
            return await _localTransactions.fetchTransactions();
    }catch(_){
    throw AppError.exception(Exception());
    }
  }

  @override
  Future<void> updateTransaction(String messageId, TransactionMessage updatedTransaction)async {
    try{
      await _localTransactions.updateTransaction(messageId, updatedTransaction);
    }catch(_){
      throw AppError.exception(Exception());

    }
  }

}