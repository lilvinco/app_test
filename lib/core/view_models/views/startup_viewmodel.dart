import 'dart:io';
import 'package:igroove_fan_box_one/config.dart';
import 'package:igroove_fan_box_one/core/networking/custom_exception.dart';
import 'package:igroove_fan_box_one/core/services/dynamic_links_service.dart';
import 'package:igroove_fan_box_one/core/services/general_service.dart';
import 'package:igroove_fan_box_one/core/view_models/base_model.dart';
import 'package:version/version.dart';

class StartUpViewModel extends BaseModel {
  StartUpViewModel({
    required GeneralService generalService,
    // required PushNotificationService pushNotificationService,
    required DynamicLinksService dynamicLinksService,
  })  : _dynamicLinksService = dynamicLinksService,
        //       _pushNotificationService = pushNotificationService,
        _generalService = generalService;

  final GeneralService _generalService;
  final DynamicLinksService _dynamicLinksService;
  // final PushNotificationService _pushNotificationService;

  Future<void> init() async {
    try {
      await _checkVersion();
      // _pushNotificationService.initialize();
      await _dynamicLinksService.initialize();

      // // Set Intercom token
      // final String? token = await _pushNotificationService.getToken();
      // if (token == null) {
      //   throw Exception('Failed to get pushNotificationService token');
      // }

      // print("FCM Token: $token");
      // String requestID = IGrooveHelper.getRequestID();
      // // Log the FCM token
      // IGrooveLog.add(
      //     "Firebase Messaging token: $token", LogType.debugInfo, requestID);

      // // request notifications permissions
      // _pushNotificationService.requestNotificationPermissions();
    } on MinAppVersionException {
      return;
    }
  }

  Future _checkVersion() async {
    await _generalService.systemInfo();

    if (Platform.isIOS) {
      if (Version.parse(Configs.APP_VERSION) <
          Version.parse(
              _generalService.systemData!.appInstance!.iosAppVersion)) {
        throw MinAppVersionException();
      }
    } else if (Platform.isAndroid) {
      if (Version.parse(Configs.APP_VERSION) <
          Version.parse(
              _generalService.systemData!.appInstance!.androidAppVersion)) {
        throw MinAppVersionException();
      }
    }
  }
}
