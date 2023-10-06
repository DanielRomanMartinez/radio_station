part of 'audio_player_bloc.dart';

@immutable
abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();
}

class AudioPlayerStateInitial extends AudioPlayerState {
  const AudioPlayerStateInitial();

  @override
  List<Object> get props => [];
}

class AudioPlayerLoaded extends AudioPlayerState {
  final RadioStation radioStation;

  const AudioPlayerLoaded(this.radioStation);

  @override
  List<Object> get props => [radioStation];
}

class AudioLoading extends AudioPlayerLoaded {
  const AudioLoading(super.radioStation);
}

class AudioPlaying extends AudioPlayerLoaded {
  const AudioPlaying(super.radioStation);
}

class AudioPaused extends AudioPlayerLoaded {
  const AudioPaused(super.radioStation);
}

class AudioStopped extends AudioPlayerLoaded {
  const AudioStopped(super.radioStation);
}
