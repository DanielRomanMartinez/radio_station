part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
}

class HomeScreenStateInitial extends HomeScreenState {
  const HomeScreenStateInitial();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeScreenStateInitial {
  const HomeLoading();
}

class HomeLoaded extends HomeScreenStateInitial {
  final List<RadioStation> radioStations;
  final List<Country> countries;
  final List<Map<String, dynamic>> radioStationsByCountry;

  const HomeLoaded({
    required this.radioStations,
    required this.countries,
    required this.radioStationsByCountry,
  });

  @override
  List<Object> get props => [
        radioStations,
        countries,
        radioStationsByCountry,
      ];
}
