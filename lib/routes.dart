import 'package:flutter/material.dart';
import 'package:radio_station/ui/screens/home_screen/home_screen.dart';
import 'package:radio_station/ui/screens/radio_station_screen/radio_station_screen.dart';
import 'package:radio_station/ui/screens/splash_screen/splash_screen.dart';

Map<String, WidgetBuilder> _routeGenerator() {
  final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (_) => const SplashScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    RadioStationScreen.routeName: (_) => const RadioStationScreen(),
  };

  return routes;
}

final routes = _routeGenerator();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
