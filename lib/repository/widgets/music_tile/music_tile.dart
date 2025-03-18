import 'package:av_music/domain/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    super.key,
    required this.musicTitle,
    required this.musicSubTitle,
    required this.musicOnTap,
    required this.musicForIconsList,
  });

  final String musicTitle;
  final String musicSubTitle;
  final VoidCallback musicOnTap;
  final SongModel musicForIconsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: musicOnTap,
        title: Text(
          musicTitle,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        ),

        subtitle: Text(
          musicSubTitle,
          maxLines: 1,
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.lableColor),
        ),

        leading: QueryArtworkWidget(
          id: musicForIconsList.id,
          type: ArtworkType.AUDIO,
          artworkWidth: 45,
          artworkHeight: 45,
          artworkBorder: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

// leading: Container(
//           width: 26,
//           height: 26,
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.secondaryContainer,
//             borderRadius: BorderRadius.circular(10),
//           ),

//           child: Center(child: Icon(Icons.music_note, color: Colors.grey)),
//         )
