import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:igroove_fan_box_one/base/info.dart';
import 'package:igroove_fan_box_one/model/device_info_model.dart';

class FirebaseDeviceRegistering {
  Future<bool> register({String? loggedUserEmail}) async {
    EnvInfo envInfo = EnvInfo();

    Device device = _getDevice(envInfo);
    // Get FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    await FirebaseFirestore.instance
        .collection("registered_devices")
        .doc(device.id)
        .set(
      <String, dynamic>{
        'device_info': device.toMap(),
        'app_release': envInfo.package.version,
        'last_update': Timestamp.now(),
        'user_email': loggedUserEmail,
        'fcm_token': fcmToken,
      },
      // merge: true,
    );

    return true;
  }

  Device _getDevice(EnvInfo envInfo) {
    return Device(
      id: envInfo.device!['uniqueID'],
      name: _getDeviceName(envInfo),
      model: envInfo.device!['model'],
      systemVersion: Platform.isIOS
          ? envInfo.device!['systemVersion']
          : envInfo.device!['version.release'],
      operatingSystem: _getDeviceOS(envInfo),
      isPhysicalDevice: envInfo.device!['isPhysicalDevice'],
    );
  }

  String? _getDeviceName(EnvInfo envInfo) {
    String platform = _getPlatform();
    String? deviceName;
    switch (platform) {
      case 'android':
        String brandName =
            envInfo.device!['brand'].substring(0, 1).toUpperCase() +
                envInfo.device!['brand'].substring(1);
        deviceName = brandName + ", " + envInfo.device!['model'];
        break;
      case 'ios':
        deviceName = envInfo.device!['name'];
        break;
      default:
        deviceName = null;
    }

    return deviceName;
  }

  String? _getDeviceOS(EnvInfo envInfo) {
    String platform = _getPlatform();
    String? deviceOS;
    switch (platform) {
      case 'android':
        deviceOS = "Android " + envInfo.device!['version.release'];
        break;
      case 'ios':
        deviceOS = envInfo.device!['systemName'] +
            " " +
            envInfo.device!['systemVersion'];
        break;
      default:
        deviceOS = null;
    }

    return deviceOS;
  }

  _getPlatform() {
    String platform = Platform.operatingSystem;
    return platform;
  }
}
