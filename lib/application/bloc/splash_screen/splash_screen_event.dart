part of 'splash_screen_bloc.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();
}

// Events to Load information

class SplashScreenGetNextPageEvent extends SplashScreenEvent {
  const SplashScreenGetNextPageEvent();

  @override
  List<Object?> get props => [];
}
