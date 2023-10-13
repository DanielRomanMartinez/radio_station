import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/model/value_object/response.dart';
import 'package:radio_station/domain/repositories/favorite_radio_station_repository.dart';
import 'package:radio_station/domain/services/http_service.dart';
import 'package:radio_station/infrastructure/repositories/http/http_radio_station_repository.dart';

import 'http_radio_station_repository_test.mocks.dart';

@GenerateMocks([
  HttpService,
  FavoriteRadioStationRepository,
])
void main() {
  group('Tests over Super HeroRepository', () {
    final Faker faker = Faker();
    final HttpService httpService = MockHttpService();
    final FavoriteRadioStationRepository favoriteRadioStationRepository =
        MockFavoriteRadioStationRepository();
    final HttpRadioStationRepository repository = HttpRadioStationRepository(
      httpService,
      favoriteRadioStationRepository,
    );

    // TODO: Generate mock generator

    final int id = faker.randomGenerator.integer(5);
    final String name = faker.lorem.words(1).join('');
    final String genre = faker.lorem.words(1).join('');
    final String url = faker.lorem.words(5).join('-');
    final String image = faker.lorem.words(5).join('');

    final String httpMockResponseOK = '''
{
	"stations": [
		{
			"radio_id": "$id",
			"radio_name": "$name",
			"genre": "$genre",
			"radio_url": "$url",
			"radio_image": "$image",
			"country_id": "$id",
			"country_name": "$name",
			"country_flag": "$image"
		}
	]
}''';

    test('Connection OK - Radio Station OK', () async {
      when(
        httpService.get(
          Uri(
            scheme: HttpRadioStationRepository.scheme,
            host: HttpRadioStationRepository.urlHost,
            path: HttpRadioStationRepository.allStationsByCountry,
            queryParameters: {
              'limit': '10',
              'page': '1',
              'country_id':
                  HttpRadioStationRepository.spainCountryId.toString(),
            },
          ),
          headers: HttpRadioStationRepository.xRapidHeaders,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            body: httpMockResponseOK,
            statusCode: 200,
            headers: const {'header': 'mock'},
          ),
        ),
      );

      when(favoriteRadioStationRepository.read(id: id))
          .thenAnswer((_) => Future.value(null));

      expect(
          await repository.getStationsByCountry(), isA<List<RadioStation>>());
    });
  });
}
