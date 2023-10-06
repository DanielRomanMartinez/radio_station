import 'package:equatable/equatable.dart';
import 'package:radio_station/domain/exceptions/malformed_map_exception.dart';

class RadioStation extends Equatable {
  final int id;
  final String name;
  final String image;
  final String url;

  const RadioStation({
    required this.id,
    required this.name,
    required this.image,
    required this.url,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        url,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'image': image,
        'url': url,
      };

  factory RadioStation.fromMap(Map<String, dynamic> map) {
    if (map['radio_id'] is! String ||
        map['radio_name'] is! String ||
        map['radio_image'] is! String ||
        map['radio_url'] is! String) {
      throw MalformedRadioStationMapException(map);
    }

    return RadioStation(
      id: int.parse(map['radio_id']),
      name: map['radio_name'],
      image: map['radio_image'],
      url: map['radio_url'],
    );
  }
}

class MalformedRadioStationMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedRadioStationMapException(this.map);
}
