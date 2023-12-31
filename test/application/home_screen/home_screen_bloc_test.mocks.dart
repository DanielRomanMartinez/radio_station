// Mocks generated by Mockito 5.4.2 from annotations
// in radio_station/test/application/home_screen/home_screen_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:radio_station/domain/model/objects/radio_station.dart' as _i4;
import 'package:radio_station/domain/services/radio_station_service.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [RadioStationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockRadioStationService extends _i1.Mock
    implements _i2.RadioStationService {
  MockRadioStationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.RadioStation>> getStationsByCountry() =>
      (super.noSuchMethod(
        Invocation.method(
          #getStationsByCountry,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.RadioStation>>.value(<_i4.RadioStation>[]),
      ) as _i3.Future<List<_i4.RadioStation>>);
  @override
  _i3.Future<Map<String, dynamic>> getHome() => (super.noSuchMethod(
        Invocation.method(
          #getHome,
          [],
        ),
        returnValue:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i3.Future<Map<String, dynamic>>);
  @override
  _i3.Future<List<_i4.RadioStation?>> search(String? radioStationName) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [radioStationName],
        ),
        returnValue:
            _i3.Future<List<_i4.RadioStation?>>.value(<_i4.RadioStation?>[]),
      ) as _i3.Future<List<_i4.RadioStation?>>);
}
