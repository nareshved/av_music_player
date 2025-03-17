import 'package:flutter/material.dart';

class ResponsiveApp {
  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width > MediaQuery.sizeOf(context).height;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).height > MediaQuery.sizeOf(context).width;
  }
}
