import 'dart:developer';

import 'package:just_audio/just_audio.dart';

class MusicPlayerHelper {
  static final player = AudioPlayer();

  // manage music play or not at time
  static bool isPlaying = false;

  // progress bar total music value
  static Duration? totalMusicDuration;
  static Duration bufferedMusicPosValue = Duration.zero;
  static Duration currMusicPosValue = Duration.zero;

  // play music

  Future<void> playMyMusic({required String audioUrl}) async {
    try {
      totalMusicDuration = await player.setAudioSource(
        AudioSource.uri(Uri.parse(audioUrl)),
      );

      player.play();

      isPlaying = true;
    } catch (e) {
      log("error when play music : $e");
      throw Exception(e);
    }

    
  }

  // get progress bar using package

  void getMusicProgress() {
    try {
      player.positionStream.listen((event) {
        currMusicPosValue = event;
      });
      player.bufferedPositionStream.listen((event) {
        bufferedMusicPosValue = event;
      });
    } catch (e) {
      log("error when get music progress");
      throw Exception(e);
    }
  }
}
