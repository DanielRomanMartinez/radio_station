import 'package:flutter/material.dart';
import 'package:radio_station/routes.dart';
import 'package:radio_station/ui/screens/splash_screen/splash_screen.dart';

class RadioStationApp extends StatelessWidget {
  const RadioStationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.white,
          secondary: Colors.white,
          background: const Color.fromRGBO(18, 18, 18, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(18, 18, 18, 1),
          elevation: 0,
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
