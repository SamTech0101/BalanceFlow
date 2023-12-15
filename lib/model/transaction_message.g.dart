// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionMessageAdapter extends TypeAdapter<TransactionMessage> {
  @override
  final int typeId = 0;

  @override
  TransactionMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionMessage(
      id: fields[0] as String,
      bankName: fields[1] as String,
      amount: fields[2] as double,
      transactionId: fields[3] as String,
      type: fields[4] as TransactionType,
      date: fields[5] as DateTime,
      description: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionMessage obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bankName)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.transactionId)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
