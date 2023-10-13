import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/repositories/favorite_radio_station_repository.dart';
import 'package:radio_station/infrastructure/providers/hive_provider.dart';
import 'package:radio_station/infrastructure/repositories/hive/model/hive_radio_station.dart';

@LazySingleton(as: FavoriteRadioStationRepository)
class HiveFavoriteRadioStationRepository
    implements FavoriteRadioStationRepository {
  static const boxName = HiveProvider.favoriteRadioStation;

  final HiveProvider _hiveProvider;

  Box<dynamic>? _box;

  HiveFavoriteRadioStationRepository(this._hiveProvider);

  Future<Box<dynamic>> get box async {
    _box ??= (await _hiveProvider.database)[boxName]!;

    return _box!;
  }

  @override
  Future<void> addFavorite(
    RadioStation radioStation,
  ) async {
    final Box<dynamic> b = await box;
    b.put(radioStation.id, HiveRadioStation.fromRadioStation(radioStation));
  }

  @override
  Future<RadioStation?> read({
    required int id,
  }) async {
    final HiveRadioStation? d = await readRaw(id: id);
    if (d == null) return null;

    return d.toRadioStation();
  }

  Future<HiveRadioStation?> readRaw({
    required int id,
  }) async {
    final Box<dynamic> b = await box;
    final HiveRadioStation? d = await b.get(id) as HiveRadioStation?;

    return d;
  }

  @override
  Future<List<RadioStation>> getFavorites() async {
    final List<RadioStation> radioStations = [];

    final Box<dynamic> b = await box;
    if (b.keys.isNotEmpty) {
      for (final key in b.keys) {
        RadioStation? radioStation = await read(id: key);
        if (radioStation != null) radioStations.add(radioStation);
      }
    }

    return radioStations
      ..sort(
        (RadioStation b, RadioStation a) => a.id.compareTo(
          b.id,
        ),
      );
  }

  @override
  Future<void> removeFavorite(int id) async {
    final HiveRadioStation? d = await readRaw(id: id);
    if (d != null) d.delete();
  }
}
