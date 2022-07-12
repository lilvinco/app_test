import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:igroove_fan_box_one/api/igroove_api.dart';
import 'package:igroove_fan_box_one/base/info.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/igroove.dart';
import 'package:igroove_fan_box_one/management/app_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // We need to call it manually,
  // because we going to call setPreferredOrientations()
  // before the runApp() call
  WidgetsFlutterBinding.ensureInitialized();
  // Override the HttpClient object to fix the issue with
  //  doing large number of requests same time.
  HttpOverrides.global = MyHttpOverrides();

  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  // FirebaseCrashlytics.instance.enableInDevMode = true;
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  final session = await AudioSession.instance;
  await session.configure(AudioSessionConfiguration.speech());
  await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.igrooveag.fanbox.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );

  // Pass all uncaught errors from the framework to Crashlytics.

  // Init BaseProjectAPI
  final HttpClient httpClient = HttpClient();
  httpClient.connectionTimeout = const Duration(milliseconds: 20000);

  IGrooveAPI(
    client: httpClient,
    // Currently the URL version of API is not working
    url: Configs.cloudURL,
  );

  //AppModel().cashboard.clearData();
  //AppModel().product.dashboard.clearData();
  //AppInfoManagement().clearInternalLog();

  clearSecureStorageInFirstInstall();

  await EnvInfo().init();
  await AppModel().translations.getTranslations(lang: 'de');
  // Start the app

  // Than we setup preferred orientations,
  // and only after it finished we run our app
  // ignore: unawaited_futures
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(IGroove()));

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
  );
}

clearSecureStorageInFirstInstall() async {
  SharedPreferences instance = await SharedPreferences.getInstance();

  if (instance.getBool("is_first_install") == null) {
    await const FlutterSecureStorage().deleteAll();
    await instance.setBool("is_first_install", true);
  }
}

Future<bool> checkIfCanRunIntercom() async {
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    int sdkInt = androidInfo.version.sdkInt;
    return sdkInt >= 21;
  }
  return true;
}

/// This overrides the default HttpClient to
///  change the maxConnectionsPerHost value.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 50;
  }
}
