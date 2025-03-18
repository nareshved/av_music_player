import 'package:flutter/material.dart';

mixin MusicPlayerMixins {
  // get music controllers buttons
  Widget myMusicControllers({
    required VoidCallback musicPlayBtn,
    required VoidCallback musicNextBtn,
    required VoidCallback musicPreviousBtn,
    required bool isPlaying, // Add this parameter
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: musicPreviousBtn,
          icon: Icon(Icons.skip_previous_rounded),
        ),
        IconButton(
          onPressed: musicPlayBtn,
          icon: Icon(
            isPlaying
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded, // Change icon based on state
            size: 40,
          ),
        ),
        IconButton(
          onPressed: musicNextBtn,
          icon: Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }

  // get music progress bar using package
}
