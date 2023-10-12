import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';
import 'package:radio_station/application/bloc/home_screen/home_screen_bloc.dart';
import 'package:radio_station/ui/common/widgets/loading_btn/loading_btn.dart';
import 'package:radio_station/ui/common/widgets/play_pause_btn/play_pause_btn.dart';
import 'package:radio_station/ui/common/widgets/stop_btn/stop_btn.dart';
import 'package:radio_station/ui/screens/radio_station_screen/radio_station_screen.dart';

part 'widgets/list_radio_stations/list_radio_stations.dart';
part 'widgets/mini_audio_player/mini_audio_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/splash_screen/radio_station_logo.png',
          width: 150,
        ),
        title: const Text('Radio Station'),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          const ListRadioStations(),
          MiniAudioPlayer(),
        ],
      ),
    );
  }
}
