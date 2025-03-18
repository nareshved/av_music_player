import 'dart:developer';

import 'package:av_music/data/bloc/music_bloc/music_events.dart';
import 'package:av_music/data/bloc/music_bloc/music_states.dart';
import 'package:av_music/data/music_helper/music_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicBloc extends Bloc<MusicEvents, MusicStates> {
  MusicHelper musicHelper;
  MusicBloc({required this.musicHelper}) : super(MusicInitialState()) {
    on<GetAllMusicEvent>((event, emit) async {
      emit(MusicLoadingState());
      try {
        await musicHelper.getAllDeviceMusic();

        emit(MusicLoadedState(allMusic: musicHelper.allMusicLocalDeviceList));
      } catch (e) {
        log(e.toString());

        MusicErrorState(errorMsg: e.toString());
      }
    });

    on<GetStoragePermissionEvent>((event, emit) {
      emit(MusicLoadingState());

      try {
        musicHelper.getStoragePermission();

        emit(MusicLoadedState(allMusic: musicHelper.allMusicLocalDeviceList));
      } catch (e) {
        log(e.toString());

        emit(MusicErrorState(errorMsg: e.toString()));
      }
    });

    // on<CheckPermissionEvent>((event, emit) async {
    //   emit(MusicLoadingState());

    //   try {
    //     await MusicHelperPermissionsState().checkPermission();

    //     emit(MusicLoadedState(allMusic: musicHelper.allMusicLocalDeviceList));
    //   } catch (e) {
    //     log(e.toString());
    //     emit(MusicErrorState(errorMsg: e.toString()));
    //   }
    // });
  }
}
