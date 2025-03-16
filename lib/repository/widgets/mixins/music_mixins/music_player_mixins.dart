import 'package:av_music/repository/widgets/music_controllers/music_controllers.dart';
import 'package:flutter/widgets.dart';

mixin MusicPlayerMixins {
  // get music controllers buttons
  Widget myMusicControllers({
    required VoidCallback musicPlayBtn,
    required VoidCallback musicNextBtn,
    required VoidCallback musicPreviousBtn,
  }) {
    return MusicControllers(
      musicNextBtn: musicNextBtn,
      musicPlayBtn: musicPlayBtn,
      musicPreviousBtn: musicPreviousBtn,
    );
  }

  // get music progress bar using package
}
