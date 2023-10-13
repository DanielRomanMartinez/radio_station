import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:radio_station/infrastructure/repositories/hive/hive_favorite_radio_station_repository.dart';
import 'package:radio_station/infrastructure/repositories/hive/model/hive_country.dart';
import 'package:radio_station/infrastructure/repositories/hive/model/hive_radio_station.dart';

@lazySingleton
class HiveProvider {
  static const favoriteRadioStation = 'favoriteRadioStation';

  bool _isInitializing = false;
  Map<String, Box<dynamic>>? _database;

  HiveProvider();

  Future<Map<String, Box<dynamic>>> get database async {
    if (_database == null && !_isInitializing) {
      try {
        lock();
        _database = await _initialize();
        release();
      } catch (e) {
        release();
      }
    } else if (_isInitializing) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await database;
    }

    return _database!;
  }

  void lock() {
    _isInitializing = true;
  }

  void release() {
    _isInitializing = false;
  }

  Future<void> dispose() async {
    await Hive.close();
    _database = null;
  }

  Future<Map<String, Box<dynamic>>> _initialize() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(HiveRadioStationAdapter())
      ..registerAdapter(HiveCountryAdapter());

    final Map<String, Box<dynamic>> boxes = {};
    boxes[HiveFavoriteRadioStationRepository.boxName] =
        await Hive.openBox<HiveRadioStation>(favoriteRadioStation);

    return boxes;
  }
}
