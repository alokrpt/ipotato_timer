import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'audio_player.dart';

class AudioPlayerImpl extends AudioPlayer {
  final Audio audio;
  final AssetsAudioPlayer audioPlayer;

  AudioPlayerImpl({
    required this.audio,
    required this.audioPlayer,
  });
  @override
  void play() {
    debugPrint('play');
    stop();
    audioPlayer.open(
      audio,
      loopMode: LoopMode.playlist,
      playInBackground: PlayInBackground.enabled,
      showNotification: true,
    );
  }

  @override
  void stop() {
    audioPlayer.stop();
  }
}
