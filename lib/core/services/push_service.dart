import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/helpers/utils.dart';
import 'package:igroove_fan_box_one/model/assets_model.dart';
import 'package:igroove_fan_box_one/model/releases_model.dart';
import 'package:igroove_fan_box_one/ui/widgets/full_media_player_widget.dart';
import 'package:provider/provider.dart';

class PushService {
  PushService() {
    initialize();
  }

  initialize() async {
    print("Push Service inititalize");
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // print('Firebase token: ${getToken().toString()}');
    _subScribeToChannel();

    final RemoteMessage? launchMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // On Launch
    await _handleOnLaunch(launchMessage);

    // On Message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleOnMessage(message);
    });

    // On Resume listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleOnResume(message);
    });

    FirebaseMessaging.onBackgroundMessage(
        (RemoteMessage message) => _handleOnBackgroundMessage(message));
  }

  Future<String?> getToken() => FirebaseMessaging.instance.getToken();
  static Future<String?> accessToken() => FirebaseMessaging.instance.getToken();

  Future _handleOnMessage(RemoteMessage remoteMessage) async {
    await Utils.incrementNotificationCount();
    int count = await Utils.getNotificationCount();
    print("Notification Count on _handleOnMessage => ${count.toString()}");
  }

  _subScribeToChannel() async {
    print("SubbscribeToTopic => " +
        UserService.userData!.payload!.user!.firebaseTopic!);
    await FirebaseMessaging.instance
        .subscribeToTopic(UserService.userData!.payload!.user!.firebaseTopic!)
        .then((value) => print('Subscription Successful'))
        .catchError((e) => print('Subscription Failed $e'));
    String? token = await FirebaseMessaging.instance.getToken();
    print("Firebase token => $token");

    UserService userService =
        Provider.of(AppKeys.navigatorKey.currentState!.context, listen: false);
    await userService.sendFirebaseToken(token: token!);
  }

  Future _handleOnLaunch(RemoteMessage? remoteMessage) async {
    if (remoteMessage == null) {
      return;
    }

    // await Firebase.initializeApp();
    await Future.delayed(const Duration(milliseconds: 1000));
    await _handleOnResume(remoteMessage);
  }

  Future _handleOnResume(RemoteMessage remoteMessage) async {
    Map<String, dynamic> message = remoteMessage.data;
    BuildContext context = AppKeys.navigatorKey.currentContext!;
    UserService userService = Provider.of(context, listen: false);
    if (message["digitalFanBoxAsset"] == null) {
      await userService.markAsRead(id: int.parse(message['notification_id']));
      int count = await Utils.getNotificationCount();
      print("Notification Count after _handleOnResume => ${count.toString()}");
      MyAudioHandler.streamControllerHomePage.add(2);
      await Future.delayed(const Duration(milliseconds: 400));
      return;
    }

    Map<String, dynamic> data = jsonDecode(message['digitalFanBoxAsset']);
    AssetModel element = AssetModel.fromJson(Map<String, dynamic>.from(data));

    await userService.markAsRead(id: int.parse(message['notification_id']));
    int count = await Utils.getNotificationCount();
    print("Notification Count after _handleOnResume => ${count.toString()}");
    element = await getAsset(id: element.id!);

    if (element.type == 1) {
      if (MyAudioHandler.mediaPlayerData.albumtracks!.isEmpty ||
          MyAudioHandler.mediaPlayerData.albumtracks?.first.filename !=
              element.filename) {
        MyAudioHandler.updateMediaPlayerData(
          newMediaPlayerData: MediaPlayerData(
              activateStreaming: true,
              albumtracks: [element],
              trackPosition: 0,
              albumList: [
                Releases(
                  coverUrl: element.uploader!.profilePictureUrl!,
                  artist: element.uploader!.userName,
                )
              ],
              albumPosition: 0),
        );
      }
      MyAudioHandler.setYPositionOfWidget(100);
      MyAudioHandler.setShowSmallPlayer(false);

      await Navigator.pushNamed(AppKeys.navigatorKey.currentState!.context,
          AppRoutes.fullMediaPlayerWidget);
      MyAudioHandler.setShowSmallPlayer(true);
    } else if (element.type! == 2) {
      await Navigator.pushNamed(
        AppKeys.navigatorKey.currentState!.context,
        AppRoutes.fullMediaPlayerWidget,
        arguments:
            FullMediaPlayerWidgetParameters(assetPosition: 0, video: element),
      );
      // await showVideoFullPlayer(video: element!, position: widget.index);
    } else {
      print("REDIRECT TO DETAIL VIEW");
    }
  }

  Future<AssetModel> getAsset({required String id}) async {
    BuildContext context = AppKeys.navigatorKey.currentContext!;
    UserService userService = Provider.of(context, listen: false);
    AssetsResponse response = await userService.getAsset(assetID: id);
    return response.assetList![0];
  }

  Future<void> _handleOnBackgroundMessage(RemoteMessage remoteMessage) async {
    print('New OnBackgroundMessage notification: $remoteMessage');
    // await Firebase.initializeApp();
    await Utils.incrementNotificationCount();
    int count = await Utils.getNotificationCount();

    print("Notification Count after _handleOnBackgroundMessage =>"
        " ${count.toString()}");
  }
}
