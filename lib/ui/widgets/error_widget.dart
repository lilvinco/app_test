import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';

class IGrooveWidgets {
  const IGrooveWidgets();

  static Widget errorCover({EdgeInsets? padding}) {
    return Container(
      height: 40,
      width: 40,
      padding: padding,
      decoration: BoxDecoration(
        color: IGrooveTheme.colors.white6,
        border: Border.all(
          color: IGrooveTheme.colors.grey5!,
          width: 0,
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          IGrooveAssets.svgNoCover,
          fit: BoxFit.fitWidth,
          color: IGrooveTheme.colors.grey6,
        ),
      ),
    );
  }
}
