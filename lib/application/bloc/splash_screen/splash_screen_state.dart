part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenState extends Equatable {
  const SplashScreenState();
}

class SplashScreenInitial extends SplashScreenState {
  const SplashScreenInitial();

  @override
  List<Object> get props => [];
}

class SplashScreenGotNextPage extends SplashScreenState {
  final String nextPage;

  const SplashScreenGotNextPage({
    required this.nextPage,
  });

  @override
  List<Object> get props => [nextPage];
}
