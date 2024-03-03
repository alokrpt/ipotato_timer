import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioPlayer {
  final Audio _audio = Audio('assets/audio/betty_boop_tune.mp3');
  final _audioPlayer = AssetsAudioPlayer();

  void play() {
    debugPrint('play');
    stop();
    _audioPlayer.open(
      _audio,
      loopMode: LoopMode.playlist,
      playInBackground: PlayInBackground.enabled,
      showNotification: true,
    );
  }

  void stop() {
    _audioPlayer.stop();
  }
}
