import 'package:just_audio/just_audio.dart';

abstract class MusicPlayerEvents {}

class PlayMusicEvent extends MusicPlayerEvents {
  final String musicUrl;

  PlayMusicEvent({required this.musicUrl});
}

class MusicProgressEvent extends MusicPlayerEvents {
   AudioPlayer player;

  MusicProgressEvent({required this.player});
}

class PlayPauseMusic extends MusicPlayerEvents {
  AudioPlayer player;

  PlayPauseMusic({required this.player});
}
