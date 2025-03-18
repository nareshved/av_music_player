import 'dart:developer';

import 'package:av_music/data/bloc/music_player/music_player_bloc.dart';
import 'package:av_music/data/bloc/music_player/music_player_events.dart';
import 'package:av_music/data/bloc/music_player/music_player_state.dart';
import 'package:av_music/data/music_helper/music_player_helper.dart';
import 'package:av_music/repository/widgets/lottie/player_details_page/lottie_player.dart';
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
    final isPage = MediaQuery.sizeOf(context);
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.arrow_back_ios_new_rounded),
                        //   onPressed: () => Navigator.pop(context),
                        // ),
                        Icon(Icons.arrow_drop_down_rounded),
                        Text(
                          "Now Playing....",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.musicPlayerModel.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.musicPlayerModel.artist ?? "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),

                    Center(child: MyLottiePlayer()),

                    Container(
                      width: isPage.width * 0.92,
                      height: isPage.height * 0.30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ProgressBar(
                                timeLabelType: TimeLabelType.totalTime,
                                timeLabelLocation: TimeLabelLocation.sides,
                                progress: MusicPlayerHelper.currMusicPosValue,
                                total:
                                    MusicPlayerHelper.totalMusicDuration ??
                                    Duration.zero,
                                buffered:
                                    MusicPlayerHelper.bufferedMusicPosValue,
                                onSeek: (newSeekValue) {
                                  state.audioPlayer.seek(newSeekValue);
                                },
                              ),
                            ),

                            Expanded(
                              child: myMusicControllers(
                                musicPlayBtn: () {
                                  BlocProvider.of<MusicPlayerBloc>(context).add(
                                    PlayPauseMusic(player: state.audioPlayer),
                                  );
                                },
                                musicNextBtn: () {},
                                musicPreviousBtn: () {},
                                isPlaying:
                                    state
                                        .audioPlayer
                                        .playing, // Add this parameter
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // SongAndValume(),
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
