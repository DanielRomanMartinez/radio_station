part of '../../../../radio_station_screen.dart';

class Wave {
  Wave(this.wave);

  factory Wave.empty(Size size) {
    return Wave(<Vibes>[]);
  }

  factory Wave.random(Size size, Random random) {
    const waveLength = 150;

    final color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1,
    );

    final bars = List.generate(
      waveLength,
      (i) => Vibes(
        random.nextDouble(),
        color,
      ),
    );

    return Wave(bars);
  }

  final List<Vibes> wave;

  static Wave lerp(Wave begin, Wave end, double t) {
    final waveLength = max(begin.wave.length, end.wave.length);
    final waves = List.generate(
      waveLength,
      (i) => Vibes.lerp(
        begin._getWaves(i) ?? end.wave[i].collapsed,
        end._getWaves(i) ?? begin.wave[i].collapsed,
        t,
      ),
    );
    return Wave(waves);
  }

  Vibes? _getWaves(int index) => (index < wave.length ? wave[index] : null);
}
