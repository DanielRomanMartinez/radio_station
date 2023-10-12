import 'package:injectable/injectable.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/repositories/radio_station_repository.dart';

@injectable
class RadioStationService {
  final RadioStationRepository _quizRepository;

  const RadioStationService(
    this._quizRepository,
  );

  Future<List<RadioStation>> getStationsByCountry() async {
    try {
      return await _quizRepository.getStationsByCountry();
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getHome() async {
    try {
      return await _quizRepository.getHome();
    } catch (_) {
      rethrow;
    }
  }
}
