part of 'favorite_screen_bloc.dart';

abstract class FavoriteScreenEvent extends Equatable {
  const FavoriteScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoriteScreen extends FavoriteScreenEvent {
  const LoadFavoriteScreen();
}

class AddFavorite extends FavoriteScreenEvent {
  final RadioStation radioStation;

  const AddFavorite({
    required this.radioStation,
  });
}

class RemoveFavorite extends FavoriteScreenEvent {
  final int id;

  const RemoveFavorite({
    required this.id,
  });
}
