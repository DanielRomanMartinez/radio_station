import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:radio_station/application.dart";
import 'package:radio_station/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const RadioStationApp());
}
