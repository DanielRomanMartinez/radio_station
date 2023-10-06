import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/ui/common/widgets/loading_btn/loading_btn.dart';
import 'package:radio_station/ui/common/widgets/play_pause_btn/play_pause_btn.dart';

part 'widgets/audio_player/audio_player.dart';
part 'widgets/audio_player/audio_player_components/radio_image.dart';
// Waves
part 'widgets/audio_player/audio_player_components/waves/vibes.dart';
part 'widgets/audio_player/audio_player_components/waves/vibes_tween.dart';
part 'widgets/audio_player/audio_player_components/waves/wave.dart';
part 'widgets/audio_player/audio_player_components/waves/waves.dart';
part 'widgets/audio_player/audio_player_components/waves/waves_painter.dart';

class RadioStationScreenParameters {
  final RadioStation radioStation;

  RadioStationScreenParameters({
    required this.radioStation,
  });
}

class RadioStationScreen extends StatefulWidget {
  static const String routeName = '/radio-station';

  const RadioStationScreen({
    super.key,
  });

  @override
  State<RadioStationScreen> createState() => _RadioStationScreenState();
}

class _RadioStationScreenState extends State<RadioStationScreen> {
  final AudioPlayerBloc _audioPlayerBloc =
      GetIt.instance.get<AudioPlayerBloc>();

  late RadioStation radioStation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments
          as RadioStationScreenParameters;
      radioStation = args.radioStation;
      _audioPlayerBloc.add(LoadAudioPlayer(radioStation: radioStation));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as RadioStationScreenParameters;
    radioStation = args.radioStation;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Now Playing'),
      ),
      body: SafeArea(
        child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          bloc: _audioPlayerBloc,
          builder: (context, state) {
            if (state is AudioPlayerStateInitial) {
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
