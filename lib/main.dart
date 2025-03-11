import 'package:av_music/domain/utils/app_theme.dart';
import 'package:av_music/repository/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
