import 'package:radio_station/domain/exceptions/repository_error_exception.dart';

class RadioStationsNotFoundException implements RepositoryErrorException {
  const RadioStationsNotFoundException();
}
