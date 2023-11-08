import 'package:equatable/equatable.dart';
import 'package:radio_station/domain/exceptions/malformed_map_exception.dart';
import 'package:radio_station/domain/model/objects/country.dart';

class RadioStation extends Equatable {
  final int id;
  final String name;
  final String genre;
  final String image;
  final String url;
  final bool isFavorite;
  final Country country;

  const RadioStation({
    required this.id,
    required this.name,
    required this.genre,
    required this.image,
    required this.url,
    required this.isFavorite,
    required this.country,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        genre,
        image,
        url,
        isFavorite,
        country,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'genre': genre,
        'image': image,
        'url': url,
        'is_favorite': isFavorite,
        'country': country,
      };

  factory RadioStation.fromMap(Map<String, dynamic> map) {
    if (map['radio_id'] is! String ||
        map['radio_name'] is! String ||
        map['genre'] is! String ||
        map['radio_image'] is! String ||
        map['radio_url'] is! String ||
        map['is_favorite'] is! bool) {
      throw MalformedRadioStationMapException(map);
    }

    return RadioStation(
      id: int.parse(map['radio_id']),
      name: map['radio_name'],
      genre: map['genre'],
      image: map['radio_image'],
      url: map['radio_url'],
      isFavorite: map['is_favorite'],
      country: map['country'],
    );
  }
}

class MalformedRadioStationMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedRadioStationMapException(this.map);
}
