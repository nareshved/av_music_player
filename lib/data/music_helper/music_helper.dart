import 'dart:developer';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicHelper {
  List<SongModel> allMusicLocalDeviceList =
      []; // all songs add to this after fetch
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<void> getAllDeviceMusic() async {
    try {
      allMusicLocalDeviceList = await _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      log(allMusicLocalDeviceList.length.toString());
      // log(allMusicLocalDeviceList[0].title);
    } catch (e) {
      log("error not get all Songs from device");

      throw Exception(e);
    }
  }

  Future<bool> getStoragePermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    }

    var status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    }

    // For Android 13+
    if (await Permission.audio.isGranted) {
      return true;
    }
    status = await Permission.audio.request();
    return status.isGranted;
  }
}
