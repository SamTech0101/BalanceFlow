

import 'package:BalanceFlow/model/total_balance.dart';
import 'package:flutter/material.dart';

import '../model/transaction_message.dart';

abstract class TransactionMessageService {
  Future<List<TransactionMessage>> fetchTransactions();
  Future<void> addTransaction(TransactionMessage message);

  Future<void> deleteTransactionMessage(String messageId);

  Future<void> updateTransaction(
      UniqueKey messageId, TransactionMessage updatedTransaction);

  Future<TotalBalanceModel> calculateTotalBalance();
}