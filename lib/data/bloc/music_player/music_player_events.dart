abstract class MusicPlayerEvents {}

class PlayMusicEvent extends MusicPlayerEvents {
  final String musicUrl;

  PlayMusicEvent({required this.musicUrl});
}

class MusicProgressEvent extends MusicPlayerEvents {
  Duration totalMusicDuration, bufferedMusicPosValue, currMusicPosValue;

  MusicProgressEvent({
    required this.bufferedMusicPosValue,
    required this.currMusicPosValue,
    required this.totalMusicDuration,
  });
}
