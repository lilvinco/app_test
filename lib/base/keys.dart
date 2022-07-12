import 'package:flutter/widgets.dart';

/// This class contains all app specefic keys.
/// All Key objects should be created here as static final members.
class AppKeys {
  // Spash Screen
  static final Key splashScreen = const Key('__splashScreen__');

  // Login Screen
  static final Key loginScreen = const Key('__loginScreen__');

  // Register Screen
  static final Key registerScreen = const Key('__registerScreen__');

  // Home Screen
  static final Key homeScreen = const Key('__homeScreen__');

  // Forgot password Screen
  static final Key forgotpassword = const Key('__forgotScreen__');

  // Navigator key
  // ignore: lines_longer_than_80_chars
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
