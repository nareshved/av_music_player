import 'package:on_audio_query/on_audio_query.dart';

abstract class MusicStates {}

class MusicInitialState extends MusicStates {}

class MusicLoadingState extends MusicStates {}

class MusicLoadedState extends MusicStates {
  List<SongModel> allMusic;

  MusicLoadedState({required this.allMusic});
}

class MusicErrorState extends MusicStates {
  String errorMsg;

  MusicErrorState({required this.errorMsg});
}
