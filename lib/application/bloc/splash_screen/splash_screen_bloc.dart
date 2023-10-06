import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/services/ui/splash_service.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

@lazySingleton
class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final SplashService _splashService;

  SplashScreenBloc(
    this._splashService,
  ) : super(const SplashScreenInitial()) {
    on<SplashScreenGetNextPageEvent>(_handleGetNextPageEvent);
  }

  void _handleGetNextPageEvent(
    SplashScreenGetNextPageEvent event,
    Emitter<SplashScreenState> emit,
  ) async {
    final String nextPage = await _splashService.getNextPage();
    emit(SplashScreenGotNextPage(nextPage: nextPage));
  }
}
