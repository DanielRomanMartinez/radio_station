part of 'search_screen_bloc.dart';

@immutable
abstract class SearchScreenState extends Equatable {
  const SearchScreenState();
}

class SearchScreenStateInitial extends SearchScreenState {
  const SearchScreenStateInitial();

  @override
  List<Object> get props => [];
}

class DoingSearch extends SearchScreenStateInitial {
  const DoingSearch();
}

class SearchCompleted extends SearchScreenStateInitial {
  final List<RadioStation?> radioStations;
  const SearchCompleted(this.radioStations);

  @override
  List<Object> get props => [
        radioStations,
      ];
}

class SearchError extends SearchScreenStateInitial {}
