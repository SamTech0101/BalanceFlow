
enum TransactionType {
  credit,
  debit,
  atmWithdrawal,
}

class TransactionMessage {

  final String id = DateTime.now().toIso8601String();
  final double amount;
  final String transactionId;
  final TransactionType type;
  final String account;
  final DateTime date;

  TransactionMessage({
    required this.amount,
    required this.transactionId,
    required this.type,
    required this.account,
    required this.date,
  });


}
