import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';

import 'package:provider/provider.dart';

/// Holds the auth token and releated values.
class Auth {
  static String? authToken;

  static check() async {
    UserService userService =
        Provider.of(AppKeys.navigatorKey.currentState!.context, listen: false);
    await userService.checkAuthToken();
  }
}
