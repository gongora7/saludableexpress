// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      roleId: fields[1] as int,
      userName: fields[2] as String,
      firstName: fields[3] as String,
      lastName: fields[4] as String,
      gender: fields[5] as String,
      defaultAddressId: fields[6] as int,
      countryCode: fields[7] as String,
      phone: fields[8] as String,
      email: fields[9] as String,
      password: fields[10] as String,
      avatar: fields[11] as String,
      status: fields[12] as String,
      isSeen: fields[13] as int,
      phoneVerified: fields[14] as int,
      rememberToken: fields[15] as String,
      authIdTiwilo: fields[16] as String,
      dob: fields[17] as String,
      createdAt: fields[18] as String,
      updatedAt: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roleId)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.defaultAddressId)
      ..writeByte(7)
      ..write(obj.countryCode)
      ..writeByte(8)
      ..write(obj.phone)
      ..writeByte(9)
      ..write(obj.email)
      ..writeByte(10)
      ..write(obj.password)
      ..writeByte(11)
      ..write(obj.avatar)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.isSeen)
      ..writeByte(14)
      ..write(obj.phoneVerified)
      ..writeByte(15)
      ..write(obj.rememberToken)
      ..writeByte(16)
      ..write(obj.authIdTiwilo)
      ..writeByte(17)
      ..write(obj.dob)
      ..writeByte(18)
      ..write(obj.createdAt)
      ..writeByte(19)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
