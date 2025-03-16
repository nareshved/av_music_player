import 'package:av_music/data/music_helper/music_player_helper.dart';
import 'package:av_music/repository/widgets/music_controllers/button_controller/music_button.dart';
import 'package:flutter/material.dart';

class MusicControllers extends StatelessWidget {
  const MusicControllers({
    super.key,
    required this.musicPlayBtn,
    required this.musicNextBtn,
    required this.musicPreviousBtn,
  });

  final VoidCallback musicPlayBtn;
  final VoidCallback musicNextBtn;
  final VoidCallback musicPreviousBtn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        MusicButton(
          btnWidth: 50,
          btnHeight: 50,
          btnIcon: Icons.skip_previous_outlined,
          onTapBtn: musicPreviousBtn,
        ),
        MusicButton(
          btnWidth: 70,
          btnHeight: 70,
          btnIcon:
              MusicPlayerHelper.isPlaying
                  ? Icons.pause_circle_filled_outlined
                  : Icons.play_arrow_outlined,
          onTapBtn: musicPlayBtn,
        ),
        MusicButton(
          btnWidth: 50,
          btnHeight: 50,
          btnIcon: Icons.skip_next_outlined,
          onTapBtn: musicNextBtn,
        ),
      ],
    );
  }
}
