import 'package:flutter/material.dart';

class MusicButton extends StatelessWidget {
  const MusicButton({
    super.key,
    required this.btnWidth,
    required this.btnHeight,
    required this.btnIcon,
    required this.onTapBtn,
  });

  final double btnWidth;
  final double btnHeight;
  final IconData btnIcon;
  final VoidCallback onTapBtn;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapBtn,
      child: Container(
        width: btnWidth,
        height: btnHeight,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),

        child: Icon(btnIcon, color: Colors.white, size: 25),
      ),
    );
  }
}
