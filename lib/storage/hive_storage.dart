import 'package:BalanceFlow/model/total_balance.dart';
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
      final Box<TransactionMessage> box = await _getBox();

      await box.put(message.id, message);
    }catch(e){
      debugPrint("Error putting message in Hive box: $e");
    }

  }

  @override
  Future<void> deleteTransactionMessage(String messageId)async {
    try{
      final box = await _getBox() ;
      for (var key in box.keys) {
        if (key.contains(messageId)) {
          await box.delete(key);
          debugPrint("=====>deleteTransactionMessage success");
        }
      }
    }catch(_){
      debugPrint("=====>deleteTransactionMessage is Failed");
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
  Future<void> updateTransaction(
      UniqueKey messageId, TransactionMessage updatedTransaction) async {
    try {
      final box = await _getBox();
      await box.put(messageId.toString(), updatedTransaction);
    } catch (_) {
      throw AppError.storageError();
    }
  }

  Future<Box<TransactionMessage>> _getBox() async {
    if (!Hive.isBoxOpen(hiveTransactionKey)){
      return await Hive.openBox<TransactionMessage>(hiveTransactionKey);
    }

    return Hive.box<TransactionMessage>(hiveTransactionKey);

  }

  @override
  Future<TotalBalanceModel> calculateTotalBalance() async{
    try{
      debugPrint("calculateTotalBalance Local");

      List<TransactionMessage> transactions = await fetchTransactions();
      debugPrint("calculateTotalBalance Local Fetch");

      TotalBalanceModel totalBalanceModel = TotalBalanceModel(totalBalance: 0, income: 0, expense: 0);
      for (var item in transactions) {
        if(item.type == TransactionType.credit){
          totalBalanceModel.income += item.amount;
        }else {
          totalBalanceModel.expense += item.amount;
        }
      }
      totalBalanceModel.totalBalance = (totalBalanceModel.income - totalBalanceModel.expense);
      debugPrint("calculateTotalBalance Local ${totalBalanceModel.toString()}");

      return totalBalanceModel;
    }catch(_){
      throw AppError.storageError();

    }

  }



}
