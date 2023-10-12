import 'package:flutter/material.dart';
import 'package:radio_station/ui/screens/main_screen/main_screen.dart';
import 'package:radio_station/ui/screens/radio_station_screen/radio_station_screen.dart';
import 'package:radio_station/ui/screens/splash_screen/splash_screen.dart';

Map<String, WidgetBuilder> _routeGenerator() {
  final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (_) => const SplashScreen(),
    MainScreen.routeName: (_) => MainScreen(),
    RadioStationScreen.routeName: (_) => const RadioStationScreen(),
  };

  return routes;
}

final routes = _routeGenerator();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
