import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/repositories/favorite_radio_station_repository.dart';

@injectable
class FavoriteRadioStationService {
  final FavoriteRadioStationRepository _favoriteRadioStationRepository;

  const FavoriteRadioStationService(
    this._favoriteRadioStationRepository,
  );

  Future<RadioStation?> read(int id) async {
    try {
      return await _favoriteRadioStationRepository.read(id: id);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<RadioStation>> getFavorites() async {
    try {
      return await _favoriteRadioStationRepository.getFavorites();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> addFavorite(RadioStation radioStation) async {
    try {
      return await _favoriteRadioStationRepository.addFavorite(radioStation);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      return await _favoriteRadioStationRepository.removeFavorite(id);
    } catch (_) {
      rethrow;
    }
  }
}
