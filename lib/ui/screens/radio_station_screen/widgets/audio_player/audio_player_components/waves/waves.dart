part of '../../../../radio_station_screen.dart';

class Waves extends StatefulWidget {
  final bool isPlaying;
  final state = _WavesState();

  Waves({
    required this.isPlaying,
    super.key,
  });

  @override
  State<Waves> createState() => _WavesState();

  void changeWaves() {
    state.changeWave();
  }
}

class _WavesState extends State<Waves> with TickerProviderStateMixin {
  static const size = Size(100.0, 5.0);
  final random = Random();

  late AnimationController animation;
  late VibesTween tween;

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    tween = VibesTween(
      Wave.empty(size),
      Wave.random(size, random),
    );

    animation.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        changeWave();
      }
    });

    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeWave() {
    setState(() {
      tween = VibesTween(
        tween.evaluate(animation),
        Wave.random(size, random),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.00,
      height: 330.00,
      padding: const EdgeInsets.all(55.0),
      child: widget.isPlaying
          ? CustomPaint(
              size: size,
              painter: WavesPainter(
                tween.animate(animation),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
