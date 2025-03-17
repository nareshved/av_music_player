import 'package:av_music/domain/utils/app_colors.dart';
import 'package:flutter/material.dart';

final mDarkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "poppins",
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    secondary: AppColors.bg2ContainerColor, // other alubum container
    primaryContainer: AppColors.bgContainerColor, // home conatiner
    // secondary: AppColors.primarySecondColor,
    secondaryContainer:
        AppColors.detailPageContainerColor, // song details circle container
    onSecondary: AppColors.lableColor,
   // surface: AppColors.bgColor,
    // onSurface: AppColors.fontColor,
  ),

  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "poppins",
      fontSize: 18,
      fontWeight: FontWeight.w500, // medium 500
      overflow: TextOverflow.ellipsis,
    ),
    bodyMedium: TextStyle(
      fontFamily: "poppins",
      fontSize: 18,
      fontWeight: FontWeight.w400, // regular 400
      overflow: TextOverflow.ellipsis,
    ),
    bodySmall: TextStyle(
      fontFamily: "poppins",
      fontSize: 12,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      fontFamily: "poppins",
      fontSize: 10,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);
