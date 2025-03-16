import 'package:av_music/data/bloc/music_player/music_player_bloc.dart';
import 'package:av_music/data/bloc/music_player/music_player_events.dart';
import 'package:av_music/data/bloc/music_player/music_player_state.dart';
import 'package:av_music/data/music_helper/music_helper.dart';
import 'package:av_music/domain/utils/app_info.dart';
import 'package:av_music/domain/utils/assets_path.dart';
import 'package:av_music/repository/pages/music_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageMusic extends StatefulWidget {
  const HomePageMusic({super.key});

  @override
  State<HomePageMusic> createState() => _HomePageMusicState();
}

class _HomePageMusicState extends State<HomePageMusic> {
  final MusicHelper musicHelper = MusicHelper();
  bool hasPermission = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<void> checkPermission() async {
    setState(() => isLoading = true);

    // For Android 13 and above
    var audioPermission = await Permission.audio.request();
    var storagePermission = await Permission.storage.request();
    var externalStorage = await Permission.manageExternalStorage.request();

    // Check if all permissions are granted
    hasPermission =
        audioPermission.isGranted &&
        (storagePermission.isGranted || externalStorage.isGranted);

    if (hasPermission) {
      await musicHelper.getAllDeviceMusic();

      // await Permission.audio.status;
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset(
                color: Theme.of(context).colorScheme.primary,
                width: 25,
                height: 25,
                AssetsPath.appLogo,
              ),
              const SizedBox(width: 14),
              Text(
                AppInfo.appName,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : !hasPermission
                ? Center(
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.folder_off, size: 64),
                      // const SizedBox(height: 16),
                      Text(
                        'Storage permission is required to access music',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      // const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: checkPermission,
                        icon: const Icon(Icons.folder_open),
                        label: Text(
                          'Grant Permission',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                )
                : musicHelper.allMusicLocalDeviceList.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.music_off, size: 64),
                      SizedBox(height: 16),
                      Text(
                        'No music found on device',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
                : BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: musicHelper.allMusicLocalDeviceList.length,
                      itemBuilder: (context, index) {
                        final music =
                            musicHelper.allMusicLocalDeviceList[index];
                        return ListTile(
                          leading: const Icon(Icons.music_note),
                          title: Text(
                            music.title,
                            maxLines: 1,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                          ),
                          subtitle: Text(
                            music.artist ?? 'Unknown Artist',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          onTap: () {
                            BlocProvider.of<MusicPlayerBloc>(
                              context,
                            ).add(PlayMusicEvent(musicUrl: music.data));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MusicDetailsPage(
                                      musicPlayerModel: music,
                                    ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
