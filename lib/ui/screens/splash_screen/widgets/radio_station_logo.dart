part of '../splash_screen.dart';

class RadioStationLogo extends StatelessWidget {
  const RadioStationLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/splash_screen/radio_station_logo.png',
      width: 150,
    );
  }
}
