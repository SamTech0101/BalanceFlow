import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:readsms/model/sms.dart';

abstract class TransactionEvent{}
class LoadBankTransactions extends TransactionEvent{}
class CalculateTotalBalance extends TransactionEvent{}
class ShowGraphTransaction extends TransactionEvent{}
class UpdateBankTransaction extends TransactionEvent{
  final TransactionMessage transactionMessage;
  UpdateBankTransaction({required this.transactionMessage});
}
class DeleteBankTransaction extends TransactionEvent{
  final String id;

  DeleteBankTransaction({required this.id});

}
class AddBankTransaction extends TransactionEvent{
  final TransactionMessage transactionMessage;

  AddBankTransaction({required  this.transactionMessage});

}
class AddBankSMS extends TransactionEvent {
final SMS sms;

  AddBankSMS({required this.sms});

}
