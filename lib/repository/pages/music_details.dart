import 'dart:developer';

import 'package:av_music/data/bloc/music_player/music_player_bloc.dart';
import 'package:av_music/data/bloc/music_player/music_player_events.dart';
import 'package:av_music/data/bloc/music_player/music_player_state.dart';
import 'package:av_music/data/music_helper/music_player_helper.dart';
import 'package:av_music/repository/widgets/lottie/player_details_page/lottie_player.dart';
import 'package:av_music/repository/widgets/mixins/music_mixins/music_player_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class MusicDetailsPage extends StatefulWidget {
  MusicDetailsPage({super.key, required this.musicPlayerModel});

  final SongModel musicPlayerModel;

  bool userChangeMusic = false;

  @override
  State<MusicDetailsPage> createState() => _MusicDetailsPageState();
}

class _MusicDetailsPageState extends State<MusicDetailsPage>
    with MusicPlayerMixins {
  @override
  void initState() {
    super.initState();

    // Initialize the playlist
    final audioQuery = OnAudioQuery();
    audioQuery
        .querySongs(
          sortType: SongSortType.TITLE,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
        )
        .then((songs) {
          MusicPlayerHelper.playlist = songs;
          // Find current song index
          MusicPlayerHelper.currentIndex = songs.indexWhere(
            (song) => song.id == widget.musicPlayerModel.id,
          );
        });

    BlocProvider.of<MusicPlayerBloc>(
      context,
    ).add(MusicProgressEvent(player: AudioPlayer()));
  }

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
              // this MusicProgressEvent for update music duration in ui real time
              BlocProvider.of<MusicPlayerBloc>(
                context,
              ).add(MusicProgressEvent(player: state.audioPlayer));
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
                          widget.userChangeMusic
                              ? MusicPlayerHelper.musicTitle!
                              : widget.musicPlayerModel.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.userChangeMusic
                              ? MusicPlayerHelper.musicTitle!
                              : widget.musicPlayerModel.artist ?? "",
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
                                isPlaying: state.audioPlayer.playing,
                                musicPlayBtn: () {
                                  if (state.audioPlayer.playing) {
                                    state.audioPlayer.pause();
                                  } else {
                                    state.audioPlayer.play();
                                  }
                                },
                                musicNextBtn: () {
                                  widget.userChangeMusic = true;
                                  MusicPlayerHelper.playNext(state.audioPlayer);
                                },
                                musicPreviousBtn: () {
                                  widget.userChangeMusic = true;
                                  MusicPlayerHelper.playPrevious(
                                    state.audioPlayer,
                                  );
                                },
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
