import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

@lazySingleton
class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer player = AudioPlayer();
  late RadioStation radioStation;
  bool isCurrentlyPlaying = false;

  AudioPlayerBloc() : super(const AudioPlayerStateInitial()) {
    on<LoadAudioPlayer>(_loadPlayer);
    on<PauseAudioPlayer>(_handlePause);
    on<PlayAudioPlayer>(_handlePlay);
    on<SetVolume>(_handleSetVolume);
    on<StopAudioPlayer>(_handleStop);
  }

  Future<void> _loadPlayer(
    LoadAudioPlayer event,
    Emitter<AudioPlayerState> emit,
  ) async {
    radioStation = event.radioStation;
    emit(AudioLoading(radioStation));

    try {
      if (isCurrentlyPlaying) await player.stop();
      await player.setVolume(0.5);
      await player.setUrl(event.radioStation.url);
      player.play();
      emit(AudioPlaying(radioStation));
      isCurrentlyPlaying = true;
    } on Exception catch (_) {
      emit(const AudioError());
    }
  }

  Future<void> _handlePause(
    PauseAudioPlayer event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await player.pause();
    emit(AudioPaused(radioStation));
    isCurrentlyPlaying = false;
  }

  Future<void> _handlePlay(
    PlayAudioPlayer event,
    Emitter<AudioPlayerState> emit,
  ) async {
    player.play();
    emit(AudioPlaying(radioStation));
    isCurrentlyPlaying = true;
  }

  Future<void> _handleSetVolume(
    SetVolume event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await player.setVolume(event.volume);
  }

  Future<void> _handleStop(
    StopAudioPlayer event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (isCurrentlyPlaying) {
      await player.stop();
      emit(const AudioStopped());
      isCurrentlyPlaying = false;
    }
  }
}
