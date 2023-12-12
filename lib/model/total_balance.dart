class TotalBalanceModel{
   double totalBalance;
   double income;
   double expense;

  TotalBalanceModel({required this.totalBalance,required this.income,required this.expense});

   @override
  String toString() {
    return 'TotalBalanceModel{totalBalance: $totalBalance, income: $income, expense: $expense}';
  }
}