import 'package:hive/hive.dart';
import 'package:radio_station/domain/model/objects/country.dart';

part 'hive_country.g.dart';

@HiveType(typeId: 2)
class HiveCountry extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String flag;

  @HiveField(3)
  final String? radioCount;

  HiveCountry({
    required this.id,
    required this.name,
    required this.flag,
    this.radioCount,
  });

  Country toCountry() => Country(
        id: id,
        name: name,
        flag: flag,
        radioCount: radioCount,
      );

  factory HiveCountry.fromCountry(Country country) => HiveCountry(
        id: country.id,
        name: country.name,
        flag: country.flag,
        radioCount: country.radioCount,
      );
}
