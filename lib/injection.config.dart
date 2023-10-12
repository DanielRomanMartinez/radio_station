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
import 'application/bloc/custom_bottom_navigation/custom_bottom_navigation_bloc.dart'
    as _i4;
import 'application/bloc/home_screen/home_screen_bloc.dart' as _i11;
import 'application/bloc/splash_screen/splash_screen_bloc.dart' as _i12;
import 'domain/repositories/radio_station_repository.dart' as _i7;
import 'domain/services/http_service.dart' as _i5;
import 'domain/services/radio_station_service.dart' as _i9;
import 'domain/services/ui/splash_service.dart' as _i10;
import 'infrastructure/repositories/http_radio_station_repository.dart' as _i8;
import 'infrastructure/services/http_service.dart' as _i6;

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
  gh.lazySingleton<_i4.CustomBottomNavigationBloc>(
      () => _i4.CustomBottomNavigationBloc());
  gh.factory<_i5.HttpService>(() => _i6.FlutterHttpService());
  gh.factory<_i7.RadioStationRepository>(
      () => _i8.HttpRadioStationRepository(gh<_i5.HttpService>()));
  gh.factory<_i9.RadioStationService>(
      () => _i9.RadioStationService(gh<_i7.RadioStationRepository>()));
  gh.factory<_i10.SplashService>(() => const _i10.SplashService());
  gh.lazySingleton<_i11.HomeScreenBloc>(
      () => _i11.HomeScreenBloc(gh<_i9.RadioStationService>()));
  gh.lazySingleton<_i12.SplashScreenBloc>(
      () => _i12.SplashScreenBloc(gh<_i10.SplashService>()));
  return getIt;
}
