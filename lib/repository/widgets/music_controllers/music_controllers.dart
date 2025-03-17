import 'package:av_music/repository/widgets/music_controllers/button_controller/music_button.dart';
import 'package:flutter/material.dart';

class MusicControllers extends StatelessWidget {
  const MusicControllers({
    super.key,
    required this.musicPlayBtn,
    required this.musicNextBtn,
    required this.musicPreviousBtn,
    required this.playerIcon,
  });

  final VoidCallback musicPlayBtn;
  final VoidCallback musicNextBtn;
  final VoidCallback musicPreviousBtn;
  final IconData playerIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        MusicButton(
          btnWidth: 50,
          btnHeight: 50,
          btnIcon: Icons.skip_previous,
          onTapBtn: musicPreviousBtn,
        ),
        MusicButton(
          btnWidth: 70,
          btnHeight: 70,
          btnIcon: playerIcon,
          onTapBtn: musicPlayBtn,
        ),
        MusicButton(
          btnWidth: 50,
          btnHeight: 50,
          btnIcon: Icons.skip_next,
          onTapBtn: musicNextBtn,
        ),
      ],
    );
  }
}
