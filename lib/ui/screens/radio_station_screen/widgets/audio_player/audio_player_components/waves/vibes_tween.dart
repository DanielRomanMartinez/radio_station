part of '../../../../radio_station_screen.dart';

class VibesTween extends Tween<Wave> {
  VibesTween(Wave begin, Wave end) : super(begin: begin, end: end);

  @override
  Wave lerp(double t) => Wave.lerp(
        begin!,
        end!,
        t,
      );
}
