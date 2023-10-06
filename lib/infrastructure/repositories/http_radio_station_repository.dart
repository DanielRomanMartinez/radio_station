import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/exceptions/radio_stations_not_found_exception.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/model/value_object/response.dart';
import 'package:radio_station/domain/repositories/radio_station_repository.dart';
import 'package:radio_station/domain/services/http_service.dart';

@Injectable(as: RadioStationRepository)
class HttpRadioStationRepository implements RadioStationRepository {
  final HttpService _httpService;

  HttpRadioStationRepository(
    this._httpService,
  );

  static const String urlAllRadiosFromCountry =
      'https://rickandmortyapi.com/api/character';
  static const int spainCountryId = 51;

  // Supposed to be in a File and added in .gitignore
  static const Map<String, String> xRapidHeaders = {
    'X-RapidAPI-Key': 'f6978ba470msh7fc4815d8677e04p11a39cjsne19b636c6f04',
    'X-RapidAPI-Host':
        'radio-world-75-000-worldwide-fm-radio-stations.p.rapidapi.com'
  };

  // Supposed to be in unique file with all endpoint routes
  static const String scheme = 'https';
  static const String urlHost =
      'radio-world-75-000-worldwide-fm-radio-stations.p.rapidapi.com';
  static const String allStationsByCountry = '/station_by_country.php';

  @override
  Future<List<RadioStation>> getAll({
    int limit = 10,
    int page = 1,
  }) async {
    final List<RadioStation> radioStations = [];

    final Response response = await _httpService.get(
      Uri(
        scheme: scheme,
        host: urlHost,
        path: allStationsByCountry,
        queryParameters: {
          'limit': limit.toString(),
          'page': page.toString(),
          'country_id': spainCountryId.toString(),
        },
      ),
      headers: xRapidHeaders,
    );

    if (response.statusCode == 200) {
      List<dynamic> radioStationsApiResponse =
          jsonDecode(response.body)['stations'];

      for (var radioStation in radioStationsApiResponse) {
        radioStations.add(RadioStation.fromMap(radioStation));
      }

      return radioStations;
    } else {
      throw const RadioStationsNotFoundException();
    }
  }
}
