import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:hive/hive.dart';

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final int typeId = 1;

  @override
  TransactionType read(BinaryReader reader) {
    int index = reader.readByte();
    return TransactionType.values[index];
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    writer.writeByte(obj.index);
  }
}
