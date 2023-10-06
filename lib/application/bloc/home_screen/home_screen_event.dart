part of 'home_screen_bloc.dart';

abstract class RadioStationScreenEvent extends Equatable {
  const RadioStationScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadRadioStations extends RadioStationScreenEvent {
  const LoadRadioStations();
}
