part of '../splash_screen.dart';

class DaniRomanLogo extends StatelessWidget {
  const DaniRomanLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Una app de:',
          style: TextStyle(
            color: Color(0xFF697886),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Dani Roman',
          style: TextStyle(
            fontFamily: 'KuaiLe',
            fontSize: 18,
            color: Color(0xFFF5897F),
          ),
        ),
      ],
    );
  }
}
