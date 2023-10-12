part of 'custom_bottom_navigation_bloc.dart';

@immutable
abstract class CustomBottomNavigationState extends Equatable {
  const CustomBottomNavigationState();
}

class CustomBottomNavigationStateInitial extends CustomBottomNavigationState {
  const CustomBottomNavigationStateInitial();

  @override
  List<Object> get props => [];
}

class PageScreenLoading extends CustomBottomNavigationStateInitial {
  const PageScreenLoading();
}

class PageScreenLoaded extends CustomBottomNavigationStateInitial {
  final PageScreen pageScreen;
  final Widget child;

  const PageScreenLoaded({
    required this.pageScreen,
    required this.child,
  });

  @override
  List<Object> get props => [
        pageScreen,
        child,
      ];
}
