import 'package:radio_station/domain/model/objects/radio_station.dart';

abstract class RadioStationRepository {
  Future<List<RadioStation>> getAll();
}
