import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/services/radio_station_service.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

@lazySingleton
class HomeScreenBloc
    extends Bloc<RadioStationScreenEvent, RadioStationScreenState> {
  final RadioStationService _radioStationService;

  HomeScreenBloc(
    this._radioStationService,
  ) : super(const RadioStationScreenInitial()) {
    on<LoadRadioStations>(_handleLoadRadioStations);
  }

  Future<void> _handleLoadRadioStations(
    LoadRadioStations event,
    Emitter<RadioStationScreenState> emit,
  ) async {
    emit(const RadioStationsLoading());
    try {
      final List<RadioStation> radioStations =
          await _radioStationService.getAll();
      emit(RadioStationsLoaded(radioStations: radioStations));
    } on Exception catch (_, e) {
      debugPrint(e.toString());
    }
  }
}
