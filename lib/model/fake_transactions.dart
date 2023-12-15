class Transaction {
  final int id;
  final double amount;
  final DateTime date;
  final String transactionType; // 'expense' or 'income'

  Transaction(this.id, this.amount, this.date, this.transactionType);
}


List<Transaction> transactions = [
  Transaction(1, 50.00, DateTime(2023, 12, 1), 'expense'),
  Transaction(2, 75.00, DateTime(2023, 12, 2), 'income'),
  Transaction(3, 20.00, DateTime(2023, 12, 3), 'expense'),
  Transaction(4, 100.00, DateTime(2023, 12, 4), 'income'),
  Transaction(5, 30.00, DateTime(2023, 12, 5), 'expense'),
  Transaction(6, 200.00, DateTime(2023, 12, 6), 'income'),
  Transaction(7, 45.00, DateTime(2023, 12, 7), 'expense'),
  Transaction(8, 60.00, DateTime(2023, 12, 8), 'income'),
  Transaction(9, 25.00, DateTime(2023, 12, 9), 'expense'),
  Transaction(10, 150.00, DateTime(2023, 12, 10), 'income'),
  // The following transactions are in the next week
  Transaction(11, 40.00, DateTime(2023, 12, 11), 'expense'),
  Transaction(12, 85.00, DateTime(2023, 12, 12), 'income'),
  Transaction(14, 50.00, DateTime(2023, 12, 13), 'expense'),
  Transaction(15, 50.00, DateTime(2023, 11, 13), 'expense'),
  Transaction(16, 80.00, DateTime(2023, 12, 14), 'expense'),
  // Transaction(13, 50.00, DateTime(2023, 11, 12), 'income'),
  // And some in a different month
  Transaction(17, 90.00, DateTime(2023, 11, 30), 'income'),
  Transaction(18, 60.00, DateTime(2023, 10, 29), 'expense'),
  Transaction(19, 60.00, DateTime(2023, 9, 11), 'income'),
  Transaction(20, 60.00, DateTime(2023, 8, 9), 'expense'),
  Transaction(21, 60.00, DateTime(2023, 7, 23), 'income'),
  Transaction(22, 60.00, DateTime(2023, 7, 1), 'income'),
  Transaction(23, 60.00, DateTime(2023, 5, 30), 'expense'),
];
