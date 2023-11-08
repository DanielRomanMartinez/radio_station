import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/model/objects/country.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/services/radio_station_service.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

@lazySingleton
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final RadioStationService _radioStationService;

  HomeScreenBloc(
    this._radioStationService,
  ) : super(const HomeScreenStateInitial()) {
    on<LoadHome>(_handleLoadHome);
  }

  Future<void> _handleLoadHome(
    LoadHome event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final Map<String, dynamic> home = await _radioStationService.getHome();
      emit(HomeLoaded(
        radioStations: home['radio_stations'],
        countries: home['countries'],
        radioStationsByCountry: home['radio_stations_by_country'],
      ));
    } on Exception catch (_, e) {
      debugPrint(e.toString());
    }
  }
}
