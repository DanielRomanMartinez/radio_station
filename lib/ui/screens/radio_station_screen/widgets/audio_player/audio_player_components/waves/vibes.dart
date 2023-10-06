part of '../../../../radio_station_screen.dart';

class Vibes {
  Vibes(this.height, this.color);

  final double height;
  final Color color;

  Vibes get collapsed => Vibes(
        0.0,
        color,
      );

  static Vibes lerp(
    Vibes begin,
    Vibes end,
    double t,
  ) {
    return Vibes(
      lerpDouble(
        begin.height,
        end.height,
        t,
      )!,
      Color.lerp(
        begin.color,
        end.color,
        t,
      )!,
    );
  }
}
