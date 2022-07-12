import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';

isSmallDevice() {
  final BuildContext context = AppKeys.navigatorKey.currentContext!;
  double screenWidth = MediaQuery.of(context).size.width;
  screenWidth = screenWidth - 30 - 3 - 20 - 20;
  double realDeviceWidth = MediaQuery.of(context).devicePixelRatio *
      MediaQuery.of(context).size.width;

  bool smallWidget = realDeviceWidth <= 640;
  return smallWidget;
}
