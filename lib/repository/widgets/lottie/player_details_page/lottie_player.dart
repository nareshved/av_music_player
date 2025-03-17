import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLottiePlayer extends StatelessWidget {
  const MyLottiePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/lottie_img/player.json",
      animate: true,
      fit: BoxFit.cover,
      repeat: true,
    );
  }
}
