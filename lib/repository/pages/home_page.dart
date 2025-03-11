import 'package:av_music/domain/utils/assets_path.dart';
import 'package:av_music/repository/widgets/music_tile/music_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageMusic extends StatelessWidget {
  const HomePageMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset(
                color: Theme.of(context).colorScheme.primary,
                width: 40,
                height: 40,
                AssetsPath.appLogo,
              ),
              Text("AV Music", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [MusicTile(), MusicTile(), MusicTile(), MusicTile()],
        ),
      ),
    );
  }
}
