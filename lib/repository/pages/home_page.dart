import 'package:av_music/data/music_helper/music_helper.dart';
import 'package:av_music/domain/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    hasPermission = await musicHelper.getStoragePermission();
    if (hasPermission) {
      await musicHelper.getAllDeviceMusic();
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
                width: 40,
                height: 40,
                AssetsPath.appLogo,
              ),
              const SizedBox(width: 16),
              Text("AV Music", style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : !hasPermission
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.folder_off, size: 64),
                      const SizedBox(height: 16),
                      const Text(
                        'Storage permission is required to access music',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: checkPermission,
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Grant Permission'),
                      ),
                    ],
                  ),
                )
                : musicHelper.allMusicLocalDeviceList.isEmpty
                ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.music_off, size: 64),
                      SizedBox(height: 16),
                      Text(
                        'No music found on device',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  itemCount: musicHelper.allMusicLocalDeviceList.length,
                  itemBuilder: (context, index) {
                    final music = musicHelper.allMusicLocalDeviceList[index];
                    return ListTile(
                      leading: const Icon(Icons.music_note),
                      title: Text(
                        music.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        music.artist ?? 'Unknown Artist',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // TODO: Implement music player
                      },
                    );
                  },
                ),
      ),
    );
  }
}
