
import 'package:hive/hive.dart';

import '../utils/constants.dart';

part 'transaction_message.g.dart';
 @HiveType(typeId: hiveTypeId0)
class TransactionMessage {

  @HiveField(0)
  final String id ;
  @HiveField(1)
  final String bankName;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final String transactionId;
  @HiveField(4)
  final TransactionType type;
  @HiveField(5)
  final DateTime date;
  @HiveField(6)
   String? description ;
  TransactionMessage(
      {required this.id,
      required this.bankName,
      required this.amount,
      required this.transactionId,
      required this.type,
      required this.date,
      this.description});
}
enum  TransactionType  {
  credit,
  debit,
  atmWithdrawal,
}