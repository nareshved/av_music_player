import 'package:just_audio/just_audio.dart';

abstract class MusicPlayerState {}

class MusicPlayerInitialState extends MusicPlayerState {}

class MusicPlayerLoadingState extends MusicPlayerState {}

class MusicPlayerLoadedState extends MusicPlayerState {
    AudioPlayer audioPlayer;
   MusicPlayerLoadedState({required this.audioPlayer});
}

class MusicPlayerErrorState extends MusicPlayerState {
  final String errorMsg;

  MusicPlayerErrorState({required this.errorMsg});
}
