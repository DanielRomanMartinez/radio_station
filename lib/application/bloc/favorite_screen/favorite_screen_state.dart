part of 'favorite_screen_bloc.dart';

@immutable
abstract class FavoriteScreenState extends Equatable {
  const FavoriteScreenState();
}

class FavoriteScreenStateInitial extends FavoriteScreenState {
  const FavoriteScreenStateInitial();

  @override
  List<Object> get props => [];
}

class FavoriteScreenLoading extends FavoriteScreenStateInitial {
  const FavoriteScreenLoading();
}

class FavoriteScreenError extends FavoriteScreenStateInitial {
  const FavoriteScreenError();
}

class FavoriteScreenLoaded extends FavoriteScreenState {
  final List<RadioStation> radioStations;

  const FavoriteScreenLoaded({
    required this.radioStations,
  });

  @override
  List<Object> get props => [
        radioStations,
      ];
}
