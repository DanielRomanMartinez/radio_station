import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/repositories/radio_station_repository.dart';

@injectable
class RadioStationService {
  final RadioStationRepository _radioStationRepository;

  const RadioStationService(
    this._radioStationRepository,
  );

  Future<List<RadioStation>> getStationsByCountry() async {
    try {
      return await _radioStationRepository.getStationsByCountry();
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getHome() async {
    try {
      return await _radioStationRepository.getHome();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<RadioStation?>> search(String radioStationName) async {
    try {
      return await _radioStationRepository.search(
          radioStationName: radioStationName);
    } catch (_) {
      rethrow;
    }
  }
}
