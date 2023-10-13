import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/services/favorite_radio_station_service.dart';

part 'favorite_screen_event.dart';
part 'favorite_screen_state.dart';

@lazySingleton
class FavoriteScreenBloc
    extends Bloc<FavoriteScreenEvent, FavoriteScreenState> {
  final FavoriteRadioStationService _favoriteRadioStationService;

  FavoriteScreenBloc(
    this._favoriteRadioStationService,
  ) : super(const FavoriteScreenStateInitial()) {
    on<LoadFavoriteScreen>(_handleLoadFavoriteScreen);
    on<AddFavorite>(_handleAddFavorite);
    on<RemoveFavorite>(_handleRemoveFavorite);
  }

  Future<void> _handleLoadFavoriteScreen(
    LoadFavoriteScreen event,
    Emitter<FavoriteScreenState> emit,
  ) async {
    emit(const FavoriteScreenLoading());

    try {
      List<RadioStation> radioStations =
          await _favoriteRadioStationService.getFavorites();
      emit(FavoriteScreenLoaded(radioStations: radioStations));
    } on Exception {
      emit(const FavoriteScreenError());
    }
  }

  Future<void> _handleAddFavorite(
    AddFavorite event,
    Emitter<FavoriteScreenState> emit,
  ) async {
    emit(const FavoriteScreenLoading());

    try {
      await _favoriteRadioStationService.addFavorite(event.radioStation);
      List<RadioStation> radioStations =
          await _favoriteRadioStationService.getFavorites();
      emit(FavoriteScreenLoaded(radioStations: radioStations));
    } on Exception {
      emit(const FavoriteScreenError());
    }
  }

  Future<void> _handleRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoriteScreenState> emit,
  ) async {
    emit(const FavoriteScreenLoading());

    try {
      await _favoriteRadioStationService.removeFavorite(event.id);
      List<RadioStation> radioStations =
          await _favoriteRadioStationService.getFavorites();
      emit(FavoriteScreenLoaded(radioStations: radioStations));
    } on Exception {
      emit(const FavoriteScreenError());
    }
  }
}
