// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/bloc/audio_player/audio_player_bloc.dart' as _i3;
import 'application/bloc/home_screen/home_screen_bloc.dart' as _i10;
import 'application/bloc/splash_screen/splash_screen_bloc.dart' as _i11;
import 'domain/repositories/radio_station_repository.dart' as _i6;
import 'domain/services/http_service.dart' as _i4;
import 'domain/services/radio_station_service.dart' as _i8;
import 'domain/services/ui/splash_service.dart' as _i9;
import 'infrastructure/repositories/http_radio_station_repository.dart' as _i7;
import 'infrastructure/services/http_service.dart' as _i5;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AudioPlayerBloc>(() => _i3.AudioPlayerBloc());
  gh.factory<_i4.HttpService>(() => _i5.FlutterHttpService());
  gh.factory<_i6.RadioStationRepository>(
      () => _i7.HttpRadioStationRepository(gh<_i4.HttpService>()));
  gh.factory<_i8.RadioStationService>(
      () => _i8.RadioStationService(gh<_i6.RadioStationRepository>()));
  gh.factory<_i9.SplashService>(() => const _i9.SplashService());
  gh.lazySingleton<_i10.HomeScreenBloc>(
      () => _i10.HomeScreenBloc(gh<_i8.RadioStationService>()));
  gh.lazySingleton<_i11.SplashScreenBloc>(
      () => _i11.SplashScreenBloc(gh<_i9.SplashService>()));
  return getIt;
}
