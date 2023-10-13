// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_radio_station.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveRadioStationAdapter extends TypeAdapter<HiveRadioStation> {
  @override
  final int typeId = 0;

  @override
  HiveRadioStation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveRadioStation(
      id: fields[0] as int,
      name: fields[1] as String,
      genre: fields[2] as String,
      image: fields[3] as String,
      url: fields[4] as String,
      isFavorite: fields[5] as bool,
      country: fields[6] as HiveCountry,
    );
  }

  @override
  void write(BinaryWriter writer, HiveRadioStation obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.genre)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.isFavorite)
      ..writeByte(6)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveRadioStationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
