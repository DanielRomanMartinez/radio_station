import 'package:flutter/material.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';

class StopBtn extends StatelessWidget {
  final AudioPlayerBloc bloc;
  final double iconSize;

  const StopBtn({
    super.key,
    required this.bloc,
    this.iconSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => bloc.add(const StopAudioPlayer()),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xFF73638E),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
