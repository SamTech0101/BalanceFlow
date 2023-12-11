import 'package:BalanceFlow/services/transactions_serviece.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../model/transaction_message.dart';
import '../utils/AppError.dart';
import '../utils/constants.dart';

class LocalTransactions implements TransactionMessageService{

  @override
  Future<void> addTransaction(TransactionMessage message) async{
    try{
      final Box<TransactionMessage>   box = await _getBox() ;
      await box.put(message.id, message);
      debugPrint("========addTransaction ");

    }catch(e){
      debugPrint("Error putting message in Hive box: $e");
    }

  }

  @override
  Future<void> deleteTransactionMessage(String messageId)async {
    try{

      final box = Hive.box(hiveTransactionKey);
      if(box.keys.isNotEmpty && box.keys.contains(messageId)) {
        await box.delete(messageId);
      }
    }catch(_){
      throw AppError.storageError();
    }
  }

  @override
  Future<List<TransactionMessage>> fetchTransactions() async{
    try{

      final Box<TransactionMessage>   box = await _getBox() ;

      return  box.values.toList();
    }catch(_){
      throw AppError.storageError();
    }
  }

  @override
  Future<void> updateTransaction(String messageId, TransactionMessage updatedTransaction
      )async {
    try{
      final box = await _getBox();
      await box.put(messageId, updatedTransaction);
    }catch(_){
      throw AppError.storageError();
    }
  }
  Future<Box<TransactionMessage>> _getBox()async{

    if (!Hive.isBoxOpen(hiveTransactionKey)){
      return await Hive.openBox<TransactionMessage>(hiveTransactionKey);
    }

    return Hive.box<TransactionMessage>(hiveTransactionKey);

  }



}
