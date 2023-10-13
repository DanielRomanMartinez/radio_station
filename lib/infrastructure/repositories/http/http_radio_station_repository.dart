import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/exceptions/radio_stations_not_found_exception.dart';
import 'package:radio_station/domain/model/objects/country.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/model/value_object/response.dart';
import 'package:radio_station/domain/repositories/favorite_radio_station_repository.dart';
import 'package:radio_station/domain/repositories/radio_station_repository.dart';
import 'package:radio_station/domain/services/http_service.dart';

@Injectable(as: RadioStationRepository)
class HttpRadioStationRepository implements RadioStationRepository {
  final HttpService _httpService;
  final FavoriteRadioStationRepository _favoriteRadioStationRepository;

  HttpRadioStationRepository(
    this._httpService,
    this._favoriteRadioStationRepository,
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
  static const String getHomePage = '/get_home.php';

  @override
  Future<List<RadioStation>> getStationsByCountry({
    int countryId = spainCountryId,
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
          'country_id': countryId.toString(),
        },
      ),
      headers: xRapidHeaders,
    );

    if (response.statusCode == 200) {
      List<dynamic> radioStationsApiResponse =
          jsonDecode(response.body)['stations'];

      for (final radioStation in radioStationsApiResponse) {
        Country country = Country.fromMap(radioStation);

        radioStation.addAll({
          'country': country,
        });

        final response = await _favoriteRadioStationRepository.read(
            id: int.parse(radioStation['radio_id']));

        radioStation.addAll({
          'is_favorite': response != null,
        });

        radioStations.add(RadioStation.fromMap(radioStation));
      }

      return radioStations;
    } else {
      throw const RadioStationsNotFoundException();
    }
  }

  @override
  Future<Map<String, dynamic>> getHome() async {
    final List<RadioStation> radioStations = [];
    final List<Country> countries = [];
    final List<Map<String, dynamic>> radioStationsByCountry = [];

    final Response response = await _httpService.get(
      Uri(
        scheme: scheme,
        host: urlHost,
        path: getHomePage,
      ),
      headers: xRapidHeaders,
    );

    if (response.statusCode == 200) {
      final apiResponse = jsonDecode(response.body);

      List<dynamic> radioStationsApiResponse = apiResponse['featured'];
      List<dynamic> countriesApiResponse = apiResponse['countries'];

      for (final Map<String, dynamic> radioStation
          in radioStationsApiResponse) {
        Country country = Country.fromMap(radioStation);

        radioStation.addAll({
          'country': country,
        });

        final response = await _favoriteRadioStationRepository.read(
            id: int.parse(radioStation['radio_id']));

        radioStation.addAll({
          'is_favorite': response != null,
        });

        radioStations.add(RadioStation.fromMap(radioStation));
      }

      for (int i = 0; i < countriesApiResponse.length && i < 5; i++) {
        countries.add(Country.fromMap(countriesApiResponse[i]));

        radioStationsByCountry.add({
          'country_name': countriesApiResponse[i]['country_name'],
          'radio_stations': await getStationsByCountry(
            countryId: int.parse(countriesApiResponse[i]['country_id']),
            limit: 5,
          ),
        });
      }

      return {
        "radio_stations": radioStations,
        "countries": countries,
        "radio_stations_by_country": radioStationsByCountry,
      };
    } else {
      throw const RadioStationsNotFoundException();
    }
  }
}
