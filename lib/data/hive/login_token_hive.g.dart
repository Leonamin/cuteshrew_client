// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_token_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginTokenHiveDTOAdapter extends TypeAdapter<LoginTokenHiveDTO> {
  @override
  final int typeId = 0;

  @override
  LoginTokenHiveDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginTokenHiveDTO(
      name: fields[0] as String,
      email: fields[1] as String,
      accessToken: fields[2] as String,
      tokenType: fields[3] as String,
      expires: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginTokenHiveDTO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.accessToken)
      ..writeByte(3)
      ..write(obj.tokenType)
      ..writeByte(4)
      ..write(obj.expires);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginTokenHiveDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
