import 'package:equatable/equatable.dart';
import 'package:radio_station/domain/exceptions/malformed_map_exception.dart';

class Country extends Equatable {
  final int id;
  final String name;
  final String flag;
  final String? radioCount;

  const Country({
    required this.id,
    required this.name,
    required this.flag,
    this.radioCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        flag,
        radioCount,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'flag': flag,
        'radio_count': radioCount,
      };

  factory Country.fromMap(Map<String, dynamic> map) {
    if (map['country_id'] is! String ||
        map['country_name'] is! String ||
        map['country_flag'] is! String) {
      throw MalformedCountryMapException(map);
    }

    return Country(
      id: int.parse(map['country_id']),
      name: map['country_name'],
      flag: map['country_flag'],
      radioCount: map['radio_count'],
    );
  }
}

class MalformedCountryMapException implements MalformedMapException {
  @override
  final Map<String, dynamic> map;

  MalformedCountryMapException(this.map);
}
