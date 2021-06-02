// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartEntryAdapter extends TypeAdapter<CartEntry> {
  @override
  final int typeId = 0;

  @override
  CartEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartEntry(
      id: fields[0] as int,
      quantity: fields[1] as int,
      attributes: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.attributes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
