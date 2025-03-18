// import 'package:av_music/data/bloc/music_player/music_player_bloc.dart';
// import 'package:av_music/data/bloc/music_player/music_player_state.dart';
// import 'package:av_music/data/music_helper/music_player_helper.dart';
// import 'package:av_music/repository/widgets/music_controllers/button_controller/music_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MusicControllers extends StatelessWidget {
//   const MusicControllers({
//     super.key,
//     required this.musicPlayBtn,
//     required this.musicNextBtn,
//     required this.musicPreviousBtn,
//   });

//   final VoidCallback musicPlayBtn;
//   final VoidCallback musicNextBtn;
//   final VoidCallback musicPreviousBtn;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
//       builder: (context, state) {
//         if (state is MusicPlayerLoadedState) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

//             children: [
//               MusicButton(
//                 btnWidth: 50,
//                 btnHeight: 50,
//                 btnIcon: Icons.skip_previous,
//                 onTapBtn: musicPreviousBtn,
//               ),
//               MusicButton(
//                 btnWidth: 70,
//                 btnHeight: 70,
//                 btnIcon:
//                     MusicPlayerHelper().isPlaying
//                         ? Icons.pause
//                         : Icons.play_arrow,
//                 onTapBtn: musicPlayBtn,
//               ),
//               MusicButton(
//                 btnWidth: 50,
//                 btnHeight: 50,
//                 btnIcon: Icons.skip_next,
//                 onTapBtn: musicNextBtn,
//               ),
//             ],
//           );
//         }
//         return CircularProgressIndicator.adaptive();
//       },
//     );
//   }
// }
