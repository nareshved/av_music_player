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

  // get storage permissions

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

    // fix me
    if (await Permission.audio.status.isDenied || // fix me
        await Permission.audio.status.isPermanentlyDenied) {
      status;
    }

    return status.isGranted;
  }
}

//  // check audio storage permission

// class MusicHelperPermissions extends StatefulWidget {
//   const MusicHelperPermissions({super.key});

//   @override
//   State<MusicHelperPermissions> createState() => MusicHelperPermissionsState();
// }

// class MusicHelperPermissionsState extends State<MusicHelperPermissions> {
//   final MusicHelper musicHelper = MusicHelper();
//   bool hasPermission = false;
//   bool isLoading = false;

//   Future<void> checkPermission() async {
//     setState(() => isLoading = true);
//     hasPermission = await musicHelper.getStoragePermission();
//     if (hasPermission) {
//       await musicHelper.getAllDeviceMusic();
//     }
//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Column();
//   }
// }
