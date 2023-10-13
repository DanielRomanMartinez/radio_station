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

    final Country country = Country(
      id: faker.randomGenerator.integer(5),
      name: faker.lorem.words(1).join(''),
      flag: faker.lorem.words(5).join('-'),
      radioCount: faker.randomGenerator.integer(20).toString(),
    );

    final RadioStation radioStation = RadioStation(
      id: faker.randomGenerator.integer(5),
      name: faker.lorem.words(1).join(''),
      url: faker.lorem.words(5).join('-'),
      image: faker.lorem.words(5).join(''),
      genre: faker.lorem.words(5).join(''),
      country: country,
      isFavorite: false,
    );

    final List<Country> countries = [
      country,
    ];

    final List<RadioStation> radioStations = [
      radioStation,
    ];

    final List<Map<String, dynamic>> radioStationsByCountry = [
      {
        'country_name': country.name,
        'radio_stations': radioStations,
      },
    ];

    when(radioStationService.getHome()).thenAnswer(
      (_) => Future.value({
        "radio_stations": radioStations,
        "countries": countries,
        "radio_stations_by_country": radioStationsByCountry,
      }),
    );

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
      )..add(const LoadHome()),
      expect: () => [
        const HomeLoading(),
        HomeLoaded(
          radioStations: radioStations,
          countries: countries,
          radioStationsByCountry: radioStationsByCountry,
        ),
      ],
      verify: (_) {
        verify(radioStationService.getHome()).called(1);
      },
    );
  });
}
