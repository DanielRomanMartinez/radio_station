import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_station/application/bloc/home_screen/home_screen_bloc.dart';
import 'package:radio_station/domain/model/objects/country.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/services/radio_station_service.dart';

import 'home_screen_bloc_test.mocks.dart';

@GenerateMocks([
  RadioStationService,
])
void main() {
  final Faker faker = Faker();

  final RadioStationService radioStationService = MockRadioStationService();

  group('Home Screen Bloc', () {
    // TODO: Generate MockGenerator RadioStation

    final List<RadioStation> radioStations = [
      RadioStation(
        id: faker.randomGenerator.integer(5),
        name: faker.lorem.words(1).join(''),
        url: faker.lorem.words(5).join('-'),
        image: faker.lorem.words(5).join(''),
        genre: faker.lorem.words(5).join(''),
      ),
    ];

    final List<Country> countries = [
      Country(
        id: faker.randomGenerator.integer(5),
        name: faker.lorem.words(1).join(''),
        flag: faker.lorem.words(5).join('-'),
        radioCount: faker.randomGenerator.integer(20).toString(),
      ),
    ];

    when(radioStationService.getHome()).thenAnswer((_) => Future.value({}));

    blocTest(
      'Creating Bloc',
      build: () => HomeScreenBloc(
        radioStationService,
      ),
      expect: () => [],
      verify: (_) {
        verifyNever(radioStationService.getStationsByCountry());
      },
    );

    blocTest(
      'Send Load Event',
      build: () => HomeScreenBloc(
        radioStationService,
      )..add(const LoadRadioStations()),
      expect: () => [
        const RadioStationsLoading(),
        RadioStationsLoaded(
          radioStations: radioStations,
          countries: countries,
          radioStationsByCountry: [],
        ),
      ],
      verify: (_) {
        verify(radioStationService.getStationsByCountry()).called(1);
      },
    );
  });
}
