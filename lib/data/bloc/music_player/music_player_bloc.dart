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

        emit(MusicPlayerLoadedState(audioPlayer: musicPlayerHelper.player));
      } catch (e) {
        log(e.toString());

        emit(MusicPlayerErrorState(errorMsg: e.toString()));
      }
    });

    on<MusicProgressEvent>((event, emit) async {
      emit(MusicPlayerLoadingState());

      try {
        await musicPlayerHelper.getMusicProgress(audioPlayer: event.player);

        emit(MusicPlayerLoadedState(audioPlayer: musicPlayerHelper.player));
      } catch (e) {
        log(e.toString());
        emit(MusicPlayerErrorState(errorMsg: e.toString()));
      }
    });

    on<PlayPauseMusic>((event, emit) async {
      emit(MusicPlayerLoadingState());

      try {
        await musicPlayerHelper.playPauseMusic(player: event.player);

        emit(MusicPlayerLoadedState(audioPlayer: musicPlayerHelper.player));
      } catch (e) {
        log(e.toString());
        emit(MusicPlayerErrorState(errorMsg: e.toString()));
      }
    });

    on<PlayNextMusicEvent>((event, emit) async {
      emit(MusicPlayerLoadingState());

      try {
        await musicPlayerHelper.playNextMusic(event.player);
        emit(MusicPlayerLoadedState(audioPlayer: musicPlayerHelper.player));
      } catch (e) {
        log(e.toString());
        emit(MusicPlayerErrorState(errorMsg: e.toString()));
      }
    });

    on<PlayPreviousMusicEvent>((event, emit) async {
      emit(MusicPlayerLoadingState());

      try {
        await musicPlayerHelper.playPreviousMusic(event.player);
        emit(MusicPlayerLoadedState(audioPlayer: musicPlayerHelper.player));
      } catch (e) {
        log(e.toString());
        emit(MusicPlayerErrorState(errorMsg: e.toString()));
      }
    });
  }
}
