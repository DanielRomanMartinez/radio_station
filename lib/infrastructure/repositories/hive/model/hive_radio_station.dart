import 'package:hive/hive.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/infrastructure/repositories/hive/model/hive_country.dart';

part 'hive_radio_station.g.dart';

@HiveType(typeId: 0)
class HiveRadioStation extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String genre;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String url;

  @HiveField(5)
  final bool isFavorite;

  @HiveField(6)
  HiveCountry country;

  HiveRadioStation({
    required this.id,
    required this.name,
    required this.genre,
    required this.image,
    required this.url,
    required this.isFavorite,
    required this.country,
  });

  RadioStation toRadioStation() => RadioStation(
        id: id,
        name: name,
        genre: genre,
        image: image,
        url: url,
        isFavorite: isFavorite,
        country: country.toCountry(),
      );

  factory HiveRadioStation.fromRadioStation(RadioStation radioStation) =>
      HiveRadioStation(
        id: radioStation.id,
        name: radioStation.name,
        genre: radioStation.genre,
        image: radioStation.image,
        isFavorite: radioStation.isFavorite,
        url: radioStation.url,
        country: HiveCountry.fromCountry(radioStation.country),
      );
}
