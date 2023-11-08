import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/services/radio_station_service.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

@lazySingleton
class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  final RadioStationService radioStationService;

  SearchScreenBloc(this.radioStationService)
      : super(const SearchScreenStateInitial()) {
    on<SearchRadioStation>(_searchRadioStation);
  }

  Future<void> _searchRadioStation(
    SearchRadioStation event,
    Emitter<SearchScreenState> emit,
  ) async {
    emit(const DoingSearch());

    try {
      List<RadioStation?> radioStations =
          await radioStationService.search(event.radioStationName);

      emit(SearchCompleted(radioStations));
    } on Exception catch (_) {
      emit(SearchError());
    }
  }
}
