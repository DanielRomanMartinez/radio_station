import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_station/application/bloc/home_screen/home_screen_bloc.dart';
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

    final int id = faker.randomGenerator.integer(5);
    final String name = faker.lorem.words(1).join('');
    final String url = faker.lorem.words(5).join('-');
    final String image = faker.lorem.words(5).join('');

    final List<RadioStation> radioStations = [
      RadioStation(
        id: id,
        name: name,
        url: url,
        image: image,
      ),
    ];

    when(radioStationService.getAll())
        .thenAnswer((_) => Future.value(radioStations));

    blocTest(
      'Creating Bloc',
      build: () => HomeScreenBloc(
        radioStationService,
      ),
      expect: () => [],
      verify: (_) {
        verifyNever(radioStationService.getAll());
      },
    );

    blocTest(
      'Send Load Event',
      build: () => HomeScreenBloc(
        radioStationService,
      )..add(const LoadRadioStations()),
      expect: () => [
        const RadioStationsLoading(),
        RadioStationsLoaded(radioStations: radioStations),
      ],
      verify: (_) {
        verify(radioStationService.getAll()).called(1);
      },
    );
  });
}
