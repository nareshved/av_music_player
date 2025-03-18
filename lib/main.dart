import 'package:av_music/data/bloc/music_bloc/music_bloc.dart';
import 'package:av_music/data/bloc/music_player/music_player_bloc.dart';
import 'package:av_music/data/music_helper/music_helper.dart';
import 'package:av_music/data/music_helper/music_player_helper.dart';
import 'package:av_music/domain/utils/app_theme.dart';
import 'package:av_music/repository/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  MusicPlayerBloc(musicPlayerHelper: MusicPlayerHelper()),
        ),
        BlocProvider(
          create: (context) => MusicBloc(musicHelper: MusicHelper()),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AV Music Player',
      theme: mDarkTheme,
      themeMode: ThemeMode.dark,
      home: const SplashPage(),
    );
  }
}
