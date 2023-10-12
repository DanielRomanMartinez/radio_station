import 'package:flutter/material.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';

class PlayPauseBtn extends StatelessWidget {
  final bool isPlaying;
  final AudioPlayerBloc bloc;
  final double iconSize;
  final bool hasBackgroundColor;

  const PlayPauseBtn({
    super.key,
    required this.isPlaying,
    required this.bloc,
    this.iconSize = 50,
    this.hasBackgroundColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => isPlaying
            ? bloc.add(const PauseAudioPlayer())
            : bloc.add(const PlayAudioPlayer()),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            gradient: hasBackgroundColor
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF5897F),
                      Color.fromRGBO(237, 109, 196, 1),
                    ],
                  )
                : null,
          ),
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
