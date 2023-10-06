part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object?> get props => [];
}

class LoadAudioPlayer extends AudioPlayerEvent {
  final RadioStation radioStation;
  const LoadAudioPlayer({
    required this.radioStation,
  });
}

class PauseAudioPlayer extends AudioPlayerEvent {
  const PauseAudioPlayer();
}

class PlayAudioPlayer extends AudioPlayerEvent {
  const PlayAudioPlayer();
}

class SetVolume extends AudioPlayerEvent {
  final double volume;

  const SetVolume({
    required this.volume,
  });
}

class StopAudioPlayer extends AudioPlayerEvent {
  const StopAudioPlayer();
}
