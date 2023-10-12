import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';
import 'package:radio_station/application/bloc/custom_bottom_navigation/custom_bottom_navigation_bloc.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/ui/common/widgets/loading_btn/loading_btn.dart';
import 'package:radio_station/ui/common/widgets/play_pause_btn/play_pause_btn.dart';
import 'package:radio_station/ui/screens/home_screen/home_screen.dart';

part 'widgets/audio_player/audio_player.dart';
part 'widgets/audio_player/audio_player_components/radio_image.dart';
// Waves
part 'widgets/audio_player/audio_player_components/waves/vibes.dart';
part 'widgets/audio_player/audio_player_components/waves/vibes_tween.dart';
part 'widgets/audio_player/audio_player_components/waves/wave.dart';
part 'widgets/audio_player/audio_player_components/waves/waves.dart';
part 'widgets/audio_player/audio_player_components/waves/waves_painter.dart';

class RadioStationScreen extends StatelessWidget {
  final RadioStation radioStation;

  RadioStationScreen({
    super.key,
    required this.radioStation,
  });

  final AudioPlayerBloc _audioPlayerBloc =
      GetIt.instance.get<AudioPlayerBloc>();

  final CustomBottomNavigationBloc _customBottomNavigationBloc =
      GetIt.instance.get<CustomBottomNavigationBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _customBottomNavigationBloc.add(
            const LoadPageScreen(
              pageScreen: PageScreen.home,
              child: HomeScreen(),
            ),
          ),
        ),
        title: const Text('Now Playing'),
      ),
      body: SafeArea(
        child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          bloc: _audioPlayerBloc,
          builder: (context, state) {
            if (state is! AudioPaused && state is! AudioPlaying) {
              _audioPlayerBloc.add(LoadAudioPlayer(radioStation: radioStation));
            }
            return AudioPlayer(
              isLoading: state is AudioPlayerStateInitial,
              radioStation: radioStation,
              bloc: _audioPlayerBloc,
            );
          },
        ),
      ),
    );
  }
}
