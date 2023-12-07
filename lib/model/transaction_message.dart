
enum TransactionType {
  credit,
  debit,
  atmWithdrawal,
}

class TransactionMessage {

  final String id = DateTime.now().toIso8601String();
  final String bankName;
  final double amount;
  final String transactionId;
  final TransactionType type;
  final DateTime date;
   String? description = '';
  TransactionMessage( {
    required this.bankName,
    required this.amount,
    required this.transactionId,
    required this.type,
    required this.date,
     this.description
  });


}
