import 'dart:developer';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayerHelper {
  var player = AudioPlayer();

  // manage music play or not at time
  bool isPlaying = false;

  // progress bar total music value
  static Duration? totalMusicDuration;
  static Duration bufferedMusicPosValue = Duration.zero;
  static Duration currMusicPosValue = Duration.zero;

  // for next or previous music
  static int currentIndex = 0;
  static List<SongModel> playlist = [];
  static SongModel? currentSong;

  // for update music title in details page when play next or previous music

  // static String? musicTitle, musicArtistName;

  // play music

  Future<void> playMyMusic({required String audioUrl}) async {
    try {
      totalMusicDuration = await player.setAudioSource(
        AudioSource.uri(Uri.parse(audioUrl)),
      );
      // getMusicProgress(audioPlayer: );

      // get titele for next or prev music

      player.play();
    } catch (e) {
      log("error when play music : $e");
      throw Exception(e);
    }
  }

  // get progress bar using package
  // this audioPlayer for update music duration in ui real time
  getMusicProgress({required AudioPlayer audioPlayer}) {
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

  Future<void> playPauseMusic({required AudioPlayer player}) async {
    try {
      if (player.playing) {
        player.pause();
        // isPlaying = false;
      } else {
        player.play();
        // isPlaying = true;
      }
    } catch (e) {
      log("error when get playPauseMusic");
      throw Exception(e);
    }
  }

  // Future<void> playNextMusic({
  //   required int mIndex,
  //   required List<SongModel> allMusicsList,
  // }) async {
  //   try {
  //     if (mIndex == allMusicsList.length - 1) {
  //       allMusicsList[mIndex + 1];
  //     } else {
  //       log("list index out of is ${mIndex.toString()}");
  //     }
  //   } catch (e) {
  //     log("error when play next music");
  //     throw Exception(e);
  //   }
  // }

  // Future<void> playPrevMusic({
  //   required int mIndex,
  //   required List<SongModel> allMusicsList,
  // }) async {
  //   try {} catch (e) {
  //     log("error when play previous music");
  //     throw Exception(e);
  //   }
  // }

  Future<void> playNextMusic(AudioPlayer audioPlayer) async {
    try {
      if (currentIndex < playlist.length - 1) {
        currentIndex++;
        currentSong = playlist[currentIndex];
        final uri = currentSong?.uri;
        if (uri != null) {
          await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
          await audioPlayer.play();
        }
      }
    } catch (e) {
      log("error when play next music");
      throw Exception(e);
    }
  }

  Future<void> playPreviousMusic(AudioPlayer audioPlayer) async {
    try {
      if (currentIndex > 0) {
        currentIndex--;
        currentSong = playlist[currentIndex];
        final uri = currentSong?.uri;
        if (uri != null) {
          await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
          await audioPlayer.play();
        }
      }
    } catch (e) {
      log("error when play previous music");
      throw Exception(e);
    }
  }
}
