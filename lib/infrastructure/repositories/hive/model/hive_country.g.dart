// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_country.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCountryAdapter extends TypeAdapter<HiveCountry> {
  @override
  final int typeId = 2;

  @override
  HiveCountry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCountry(
      id: fields[0] as int,
      name: fields[1] as String,
      flag: fields[2] as String,
      radioCount: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCountry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.flag)
      ..writeByte(3)
      ..write(obj.radioCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
