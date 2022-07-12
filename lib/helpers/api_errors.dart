import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/management/app_model.dart';
import 'package:igroove_fan_box_one/management/push_navigate_service.dart';
import 'package:igroove_fan_box_one/model/app_settings.dart';
import 'package:igroove_fan_box_one/ui/pages/login/login.dart';

class APIErrors {
  static const String INVALID_TOKEN = "Ungültiges Token!";
  static const String SOCKET_EXCEPTION = "There is no internet connection.";
  static const String REQUEST_TIME_OUT =
      "Request time out, please check your internet connection.";
}

class APIErrorsDialog {
  /// Go back to login screen
  static Future invalidTokenAction(BuildContext context) async {
    AppModel().appSettings.setAppSettings(
        AppSettings(showFeedbackButton: false, showRevShare: false));
    AppModel().currentPageIndex = 0;

    if (PushNavigationService.currentPageName != 'login') {
      PushNavigationService.currentPageName = 'login';
    } else {
      return;
    }

    // Future.delayed(Duration(milliseconds: 500),(){
    await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (BuildContext context) {
        return LoginPage();
      },
    ), (Route<dynamic> route) => false);

    // });
  }
}
