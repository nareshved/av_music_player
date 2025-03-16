import 'dart:developer';

import 'package:av_music/data/bloc/music_player/music_player_bloc.dart';
import 'package:av_music/data/bloc/music_player/music_player_events.dart';
import 'package:av_music/data/bloc/music_player/music_player_state.dart';
import 'package:av_music/data/music_helper/music_player_helper.dart';
import 'package:av_music/repository/widgets/mixins/music_mixins/music_player_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class MusicDetailsPage extends StatefulWidget {
  const MusicDetailsPage({super.key, required this.musicPlayerModel});

  final SongModel musicPlayerModel;

  @override
  State<MusicDetailsPage> createState() => _MusicDetailsPageState();
}

class _MusicDetailsPageState extends State<MusicDetailsPage>
    with MusicPlayerMixins {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<MusicPlayerBloc>(context).add(
      MusicProgressEvent(
        bufferedMusicPosValue: MusicPlayerHelper.bufferedMusicPosValue,
        currMusicPosValue: MusicPlayerHelper.currMusicPosValue,
        totalMusicDuration:
            MusicPlayerHelper.totalMusicDuration ?? Duration.zero,
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();

  //   MusicPlayerHelper.player.stop();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
          builder: (context, state) {
            if (state is MusicPlayerLoadingState) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            if (state is MusicPlayerErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
            if (state is MusicPlayerLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProgressBar(
                      progress: MusicPlayerHelper.currMusicPosValue,
                      total:
                          MusicPlayerHelper.totalMusicDuration ?? Duration.zero,
                      buffered: MusicPlayerHelper.bufferedMusicPosValue,
                      onSeek: (newSeekValue) {
                        state.audioPlayer.seek(newSeekValue);
                      },
                    ),

                    myMusicControllers(
                      musicPlayBtn: () {
                        if (state.audioPlayer.playing) {
                          state.audioPlayer.pause();
                        } else {
                          state.audioPlayer.play();
                        }
                      },
                      musicNextBtn: () {},
                      musicPreviousBtn: () {},
                    ),
                  ],
                ),
              );
            }

            log("error when data not loaded in music details page");

            return Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }
}
