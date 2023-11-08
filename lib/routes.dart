import 'package:flutter/material.dart';
import 'package:radio_station/ui/screens/main_screen/main_screen.dart';
import 'package:radio_station/ui/screens/splash_screen/splash_screen.dart';

Map<String, WidgetBuilder> _routeGenerator() {
  final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (_) => const SplashScreen(),
    MainScreen.routeName: (_) => MainScreen(),
  };

  return routes;
}

final routes = _routeGenerator();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
