import 'dart:developer';

import 'package:av_music/data/bloc/music_player/music_player_events.dart';
import 'package:av_music/data/bloc/music_player/music_player_state.dart';
import 'package:av_music/data/music_helper/music_player_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvents, MusicPlayerState> {
  MusicPlayerHelper musicPlayerHelper;
  MusicPlayerBloc({required this.musicPlayerHelper})
    : super(MusicPlayerInitialState()) {
    on<PlayMusicEvent>((event, emit) async {
      emit(MusicPlayerLoadingState());

      try {
        await musicPlayerHelper.playMyMusic(audioUrl: event.musicUrl);

        emit(MusicPlayerLoadedState(audioPlayer: MusicPlayerHelper.player));
      } catch (e) {
        log(e.toString());

        emit(MusicPlayerErrorState(errorMsg: e.toString()));
      }
    });

    on<MusicProgressEvent>((event, emit) {
      emit(MusicPlayerLoadingState());

      try {
        musicPlayerHelper.getMusicProgress();

        emit(MusicPlayerLoadedState(audioPlayer: MusicPlayerHelper.player));
      } catch (e) {
        log(e.toString());
        emit(MusicPlayerErrorState(errorMsg: e.toString()));
      }
    });
  }
}
