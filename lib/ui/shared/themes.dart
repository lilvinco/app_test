import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/ui/shared/typography.dart';

class AppColors {
  final Color? headerColor;
  final Color? primary;
  final Color? secondary;
  final Color? darkGrey;
  final Color? disabledColor;
  final Color? whiteColor;
  final Color? lightGrey;
  final Color? red;
  final Color? black;
  final Color? fanBoxBlack;
  final Color? white;
  final Color? grey4;
  final Color? transparent;
  final Color? gold2;
  final Color? grey;
  final Color? grey2;
  final Color? grey3;
  final Color? green;
  final Color? orange;
  final Color? blue;
  final Color? yellow;
  final Color? pink;
  final Color? white3;
  final Color? black4;
  final Color? grey12;
  final Color? white4;
  final Color? white6;
  final Color? green5;
  final Color? white10;
  final Color? red6;
  final Color? grey5;
  final Color? grey6;
  final Color? goldDark;
  final Color? black2;
  final Color? black3;
  final Color? gold;

  AppColors({
    this.headerColor,
    this.gold,
    this.grey4,
    this.primary,
    this.secondary,
    this.fanBoxBlack,
    this.darkGrey,
    this.disabledColor,
    this.whiteColor,
    this.lightGrey,
    this.red,
    this.black,
    this.pink,
    this.black2,
    this.black3,
    this.yellow,
    this.blue,
    this.orange,
    this.grey5,
    this.grey6,
    this.green,
    this.white3,
    this.grey12,
    this.grey3,
    this.gold2,
    this.white4,
    this.white,
    this.transparent,
    this.grey2,
    this.grey,
    this.white6,
    this.green5,
    this.black4,
    this.white10,
    this.goldDark,
    this.red6,
  });
}

class IGrooveTheme {
  static String fontFamily = 'Graphik';
  static double opacityLow = 0.35;
  static double opacityMiddle = 0.5;
  static double opacityHigh = 0.9;
  static double headerHeight = 54;
  static EdgeInsets headerPadding = const EdgeInsets.symmetric(horizontal: 10);
  static double headerIconHeight = 24;
  static double headerIconWidth = 24;
  static EdgeInsets headerIconPadding =
      const EdgeInsets.symmetric(horizontal: 5);

  static final double _headerMainFontSize = 18;
  static final double _headerSmallFontSize = 16;
  static MediaQueryData get mediaQueryData =>
      MediaQuery.of(AppKeys.navigatorKey.currentContext!);

  static double get headerFontSize =>
      isSmallDevice ? _headerSmallFontSize : _headerMainFontSize;
  static bool get isSmallDevice =>
      mediaQueryData.devicePixelRatio * mediaQueryData.size.width <= 640;
  static AppColors colors = AppColors();

  static ThemeData get light {
    colors = AppColors(
      fanBoxBlack: const Color.fromRGBO(114, 114, 114, 1),
      secondary: const Color.fromRGBO(255, 255, 255, 0.75),
      black: const Color.fromRGBO(114, 114, 114, 1),
      black4: const Color.fromRGBO(114, 114, 114, 1),
      transparent: const Color.fromRGBO(0, 0, 0, 0),
      blue: const Color.fromRGBO(33, 150, 243, 1),
      grey4: const Color.fromRGBO(128, 128, 128, 1),
      lightGrey: const Color.fromRGBO(43, 43, 43, 1),
      gold2: const Color.fromRGBO(225, 155, 0, 1),
      green5: const Color.fromRGBO(64, 180, 103, 1),
      black2: const Color.fromRGBO(114, 114, 114, 1),
      grey6: const Color.fromRGBO(171, 171, 171, 1),
      black3: const Color.fromRGBO(62, 62, 62, 1),
      green: const Color.fromRGBO(76, 175, 80, 1),
      darkGrey: const Color.fromRGBO(77, 77, 79, 1),
      headerColor: const Color.fromRGBO(114, 114, 114, 1),
      primary: const Color.fromRGBO(255, 255, 255, 1),
      grey5: const Color.fromRGBO(230, 230, 230, 1),
      grey3: const Color.fromRGBO(41, 41, 41, 1),
      grey12: const Color.fromRGBO(140, 145, 164, 1.0),
      grey: const Color.fromRGBO(158, 158, 158, 1),
      white4: const Color.fromRGBO(209, 211, 219, 1.0),
      goldDark: const Color.fromRGBO(85, 85, 85, 1),
      disabledColor: const Color.fromRGBO(215, 217, 221, 1),
      grey2: const Color.fromRGBO(215, 215, 215, 1),
      white10: const Color.fromRGBO(216, 216, 216, 1),
      white3: const Color.fromRGBO(226, 226, 226, 1),
      pink: const Color.fromRGBO(233, 30, 99, 1),
      whiteColor: const Color.fromRGBO(238, 238, 238, 1),
      white6: const Color.fromRGBO(246, 246, 246, 1),
      red6: const Color.fromRGBO(250, 57, 62, 1),
      red: const Color.fromRGBO(255, 60, 66, 1),
      yellow: const Color.fromRGBO(255, 235, 59, 1),
      white: const Color.fromRGBO(255, 255, 255, 1),
      orange: const Color.fromRGBO(255, 152, 0, 1),
      gold: const Color.fromRGBO(78, 65, 36, 1),
    );

    return ThemeData(
      appBarTheme: AppBarTheme(
        toolbarTextStyle: TextTheme(
            headline6: TextStyle(
          fontSize: AppKeys.navigatorKey.currentContext == null
              ? null
              : headerFontSize,
          fontFamily: "Graphik",
        )).bodyText2,
        titleTextStyle: TextTheme(
            headline6: TextStyle(
          fontSize: AppKeys.navigatorKey.currentContext == null
              ? null
              : headerFontSize,
          fontFamily: "Graphik",
        )).headline6,
      ),
      fontFamily: IGrooveFonts.primary,
      //primaryColorBrightness: Brightness.light,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.white,
      cardColor: colors.whiteColor,
      highlightColor: colors.transparent,
      focusColor: colors.transparent,
      splashColor: colors.transparent,
      hoverColor: colors.transparent,
      secondaryHeaderColor: colors.black,
      disabledColor: colors.disabledColor,
      unselectedWidgetColor: colors.whiteColor!.withOpacity(0.7),
      primaryTextTheme: TextTheme(
        headline5: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.black,
          fontSize: 19,
        ),
        button: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.whiteColor,
          fontSize: 15,
        ),
        headline6: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.darkGrey,
          fontSize: 20,
        ),
        subtitle2: TextStyle(
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic,
          color: colors.black,
          fontSize: 15,
        ),
        overline: TextStyle(
          fontWeight: FontWeight.w600,
          color: colors.primary,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.darkGrey,
          fontSize: 11,
        ),
        bodyText1: TextStyle(
          fontWeight: FontWeight.w300,
          color: colors.darkGrey,
          fontSize: 17,
        ),
        caption: TextStyle(
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic,
          color: colors.darkGrey!.withOpacity(opacityLow),
          fontSize: 16,
        ),
        headline4: TextStyle(
          fontWeight: FontWeight.w900,
          color: colors.darkGrey,
          fontSize: 22,
        ),
        headline3: TextStyle(
          fontWeight: FontWeight.w300,
          color: colors.darkGrey,
          fontSize: 20,
        ),
        headline2: TextStyle(
          fontWeight: FontWeight.w300,
          color: colors.black,
          fontSize: 12,
        ),
      ),
      iconTheme: IconThemeData(color: colors.primary),

      // cursor color
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colors.primary,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: colors.primary,
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: colors.darkGrey),
    );
  }

  static ThemeData get custom {
    colors = AppColors(
      fanBoxBlack: const Color.fromRGBO(18, 18, 18, 1),
      black: const Color.fromRGBO(0, 0, 0, 1),
      transparent: const Color.fromRGBO(0, 0, 0, 0),
      blue: const Color.fromRGBO(33, 150, 243, 1),
      lightGrey: const Color.fromRGBO(43, 43, 43, 1),
      primary: const Color.fromRGBO(48, 157, 126, 1),
      headerColor: const Color.fromRGBO(0, 0, 0, 1),
      green5: const Color.fromRGBO(64, 180, 103, 1),
      black3: const Color.fromRGBO(62, 62, 62, 1),
      grey6: const Color.fromRGBO(171, 171, 171, 1),
      green: const Color.fromRGBO(76, 175, 80, 1),
      darkGrey: const Color.fromRGBO(77, 77, 79, 1),
      grey12: const Color.fromRGBO(140, 145, 164, 1.0),
      black4: const Color.fromRGBO(26, 26, 26, 1),
      grey3: const Color.fromRGBO(41, 41, 41, 1),
      goldDark: const Color.fromRGBO(78, 65, 38, 1),
      grey: const Color.fromRGBO(158, 158, 158, 1),
      white4: const Color.fromRGBO(209, 211, 219, 1.0),
      disabledColor: const Color.fromRGBO(215, 217, 221, 1),
      gold2: const Color.fromRGBO(225, 155, 0, 1),
      grey2: const Color.fromRGBO(215, 215, 215, 1),
      white10: const Color.fromRGBO(216, 216, 216, 1),
      white3: const Color.fromRGBO(226, 226, 226, 1),
      black2: const Color.fromRGBO(18, 18, 18, 1),
      grey5: const Color.fromRGBO(230, 230, 230, 1),
      grey4: const Color.fromRGBO(128, 128, 128, 1),
      pink: const Color.fromRGBO(233, 30, 99, 1),
      whiteColor: const Color.fromRGBO(238, 238, 238, 1),
      white6: const Color.fromRGBO(246, 246, 246, 1),
      red6: const Color.fromRGBO(250, 57, 62, 1),
      red: const Color.fromRGBO(255, 60, 66, 1),
      white: const Color.fromRGBO(255, 255, 255, 1),
      orange: const Color.fromRGBO(255, 152, 0, 1),
      yellow: const Color.fromRGBO(255, 235, 59, 1),
      gold: const Color.fromRGBO(78, 65, 36, 1),
    );

    return ThemeData(
      appBarTheme: AppBarTheme(
        toolbarTextStyle: TextTheme(
            headline6: TextStyle(
          fontSize: AppKeys.navigatorKey.currentContext == null
              ? null
              : headerFontSize + 8,
          fontWeight: FontWeight.bold,
          fontFamily: "BarlowCondensed",
        )).bodyText2,
        titleTextStyle: TextTheme(
            headline6: TextStyle(
          fontSize: AppKeys.navigatorKey.currentContext == null
              ? null
              : headerFontSize + 8,
          fontWeight: FontWeight.bold,
          fontFamily: "BarlowCondensed",
        )).headline6,
      ),
      fontFamily: IGrooveFonts.primary,
      //primaryColorBrightness: Brightness.light,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.white,
      cardColor: colors.whiteColor,
      highlightColor: colors.transparent,
      focusColor: colors.transparent,
      splashColor: colors.transparent,
      hoverColor: colors.transparent,
      secondaryHeaderColor: colors.black,
      disabledColor: colors.disabledColor,
      unselectedWidgetColor: colors.whiteColor!.withOpacity(0.7),
      primaryTextTheme: TextTheme(
        headline5: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.black,
          fontSize: 19,
        ),
        button: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.whiteColor,
          fontSize: 15,
        ),
        headline6: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.darkGrey,
          fontSize: 20,
        ),
        subtitle2: TextStyle(
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic,
          color: colors.black,
          fontSize: 15,
        ),
        overline: TextStyle(
          fontWeight: FontWeight.w600,
          color: colors.primary,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.darkGrey,
          fontSize: 11,
        ),
        bodyText1: TextStyle(
          fontWeight: FontWeight.w300,
          color: colors.darkGrey,
          fontSize: 17,
        ),
        caption: TextStyle(
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic,
          color: colors.darkGrey!.withOpacity(opacityLow),
          fontSize: 16,
        ),
        headline4: TextStyle(
          fontWeight: FontWeight.w900,
          color: colors.darkGrey,
          fontSize: 22,
        ),
        headline3: TextStyle(
          fontWeight: FontWeight.w300,
          color: colors.darkGrey,
          fontSize: 20,
        ),
        headline2: TextStyle(
          fontWeight: FontWeight.w300,
          color: colors.black,
          fontSize: 12,
        ),
      ),
      iconTheme: IconThemeData(color: colors.primary),

      // cursor color
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colors.primary,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: colors.primary,
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: colors.darkGrey),
    );
  }
}
