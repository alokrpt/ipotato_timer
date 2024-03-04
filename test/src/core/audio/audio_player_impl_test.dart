import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/audio/audio_player.dart';
import 'package:ipotato_timer/src/core/audio/audio_player_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'audio_player_impl_test.mocks.dart';

@GenerateMocks([Audio, AssetsAudioPlayer])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('AudioPlayer', () {
    late AudioPlayer audioPlayer;
    late MockAudio mockAudio;
    late MockAssetsAudioPlayer mockAssetsAudioPlayer;

    setUp(() {
      mockAudio = MockAudio();
      mockAssetsAudioPlayer = MockAssetsAudioPlayer();
      audioPlayer = AudioPlayerImpl(
        audio: mockAudio,
        audioPlayer: mockAssetsAudioPlayer,
      );
    });

    test('play method should call stop and open', () {
      // Arrange
      when(mockAudio.path).thenReturn('assets/audio/betty_boop_tune.mp3');

      // Act
      audioPlayer.play();

      // Assert
      verify(mockAssetsAudioPlayer.stop()).called(1);
      verify(mockAssetsAudioPlayer.open(
        mockAudio,
        loopMode: LoopMode.playlist,
        playInBackground: PlayInBackground.enabled,
        showNotification: true,
      )).called(1);
    });

    test('stop method should call stop', () {
      // Act
      audioPlayer.stop();

      // Assert
      verify(mockAssetsAudioPlayer.stop()).called(1);
    });
  });
}
