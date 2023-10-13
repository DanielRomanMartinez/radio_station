import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';
import 'package:radio_station/application/bloc/favorite_screen/favorite_screen_bloc.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/domain/services/favorite_radio_station_service.dart';
import 'package:radio_station/ui/common/widgets/loading_btn/loading_btn.dart';
import 'package:radio_station/ui/common/widgets/play_pause_btn/play_pause_btn.dart';

part 'widgets/audio_player/audio_player.dart';
part 'widgets/audio_player/audio_player_components/fav_button/fav_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
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
    );
  }
}
