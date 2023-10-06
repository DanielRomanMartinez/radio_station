part of 'home_screen_bloc.dart';

@immutable
abstract class RadioStationScreenState extends Equatable {
  const RadioStationScreenState();
}

class RadioStationScreenInitial extends RadioStationScreenState {
  const RadioStationScreenInitial();

  @override
  List<Object> get props => [];
}

class RadioStationsLoading extends RadioStationScreenInitial {
  const RadioStationsLoading();
}

class RadioStationsLoaded extends RadioStationScreenInitial {
  final List<RadioStation> radioStations;

  const RadioStationsLoaded({
    required this.radioStations,
  });

  @override
  List<Object> get props => [
        radioStations,
      ];
}
