// lib/model/transaction_message.dart

enum TransactionType {
  credit,
  debit,
  atmWithdrawal,
}

class TransactionMessage {
  final int id;
  final double amount;
  final String transactionId;
  final TransactionType type;
  final String account;
  final DateTime date;

  TransactionMessage({
    required this.id,
    required this.amount,
    required this.transactionId,
    required this.type,
    required this.account,
    required this.date,
  });


}
