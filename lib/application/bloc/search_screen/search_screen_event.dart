part of 'search_screen_bloc.dart';

abstract class SearchScreenEvent extends Equatable {
  const SearchScreenEvent();

  @override
  List<Object?> get props => [];
}

class SearchRadioStation extends SearchScreenEvent {
  final String radioStationName;
  const SearchRadioStation({
    required this.radioStationName,
  });

  @override
  List<Object?> get props => [
        radioStationName,
      ];
}
