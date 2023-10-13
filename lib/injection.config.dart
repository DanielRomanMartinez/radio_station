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
import 'application/bloc/favorite_screen/favorite_screen_bloc.dart' as _i12;
import 'application/bloc/home_screen/home_screen_bloc.dart' as _i17;
import 'application/bloc/splash_screen/splash_screen_bloc.dart' as _i16;
import 'domain/repositories/favorite_radio_station_repository.dart' as _i9;
import 'domain/repositories/radio_station_repository.dart' as _i13;
import 'domain/services/favorite_radio_station_service.dart' as _i11;
import 'domain/services/http_service.dart' as _i6;
import 'domain/services/radio_station_service.dart' as _i15;
import 'domain/services/ui/splash_service.dart' as _i8;
import 'infrastructure/providers/hive_provider.dart' as _i5;
import 'infrastructure/repositories/hive/hive_favorite_radio_station_repository.dart'
    as _i10;
import 'infrastructure/repositories/http/http_radio_station_repository.dart'
    as _i14;
import 'infrastructure/services/http_service.dart' as _i7;

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
  gh.lazySingleton<_i5.HiveProvider>(() => _i5.HiveProvider());
  gh.factory<_i6.HttpService>(() => _i7.FlutterHttpService());
  gh.factory<_i8.SplashService>(() => const _i8.SplashService());
  gh.lazySingleton<_i9.FavoriteRadioStationRepository>(
      () => _i10.HiveFavoriteRadioStationRepository(gh<_i5.HiveProvider>()));
  gh.factory<_i11.FavoriteRadioStationService>(() =>
      _i11.FavoriteRadioStationService(
          gh<_i9.FavoriteRadioStationRepository>()));
  gh.lazySingleton<_i12.FavoriteScreenBloc>(
      () => _i12.FavoriteScreenBloc(gh<_i11.FavoriteRadioStationService>()));
  gh.factory<_i13.RadioStationRepository>(() => _i14.HttpRadioStationRepository(
        gh<_i6.HttpService>(),
        gh<_i9.FavoriteRadioStationRepository>(),
      ));
  gh.factory<_i15.RadioStationService>(
      () => _i15.RadioStationService(gh<_i13.RadioStationRepository>()));
  gh.lazySingleton<_i16.SplashScreenBloc>(
      () => _i16.SplashScreenBloc(gh<_i8.SplashService>()));
  gh.lazySingleton<_i17.HomeScreenBloc>(
      () => _i17.HomeScreenBloc(gh<_i15.RadioStationService>()));
  return getIt;
}
