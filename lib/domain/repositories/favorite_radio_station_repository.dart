import 'package:radio_station/domain/model/objects/radio_station.dart';

abstract class FavoriteRadioStationRepository {
  Future<RadioStation?> read({
    required int id,
  });
  Future<void> addFavorite(RadioStation radioStation);
  Future<void> removeFavorite(int id);
  Future<List<RadioStation>> getFavorites();
}
