part of '../../../../radio_station_screen.dart';

class WavesPainter extends CustomPainter {
  WavesPainter(this.animation) : super(repaint: animation);

  final Animation<Wave> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.translate(size.width / 2, size.height / 2);

    canvas.save();

    final radius = size.width / 2;
    final chart = animation.value;

    for (final wave in chart.wave) {
      paint.color = wave.color;
      canvas.drawLine(
        Offset(0.0, -radius),
        Offset(1.0, -radius - (wave.height * 30)),
        paint,
      );

      canvas.drawRect(
        Rect.fromLTRB(0.00, -radius, 2.00, -radius - (wave.height * 15)),
        paint,
      );
      canvas.rotate(2 * math.pi / chart.wave.length);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(WavesPainter oldDelegate) => true;
}
