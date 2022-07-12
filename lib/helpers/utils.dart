import 'dart:async';
import 'dart:io';

import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static Future<String> getFileUrl(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }

  static Future<String> saveFileIntoDocumentDirectory(
      String fileURL, String filename) async {
    // Create file
    Future<String> filePath = getFilePath(filename);

    return filePath;
  }

  static Future<String> getFilePath(String filename) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

    return filePath;
  }

  static StreamController<int> streamControllerNotifictionCount =
      StreamController.broadcast();

  static getNotificationCount() async {
    String? notificationCount =
        await const FlutterSecureStorage().read(key: 'fanappnotificationcount');

    int count = int.parse(notificationCount ?? "0");
    streamControllerNotifictionCount.add(count);
    FlutterAppBadger.updateBadgeCount(count);
    return count;
  }

  static setNotificationCount({required int count}) async {
    await const FlutterSecureStorage()
        .write(key: 'fanappnotificationcount', value: count.toString());
    FlutterAppBadger.updateBadgeCount(count);
    streamControllerNotifictionCount.add(count);
  }

  static incrementNotificationCount() async {
    String? notificationCount =
        await const FlutterSecureStorage().read(key: 'fanappnotificationcount');

    int count = int.parse(notificationCount ?? "0");
    count = count + 1;
    await const FlutterSecureStorage()
        .write(key: 'fanappnotificationcount', value: count.toString());
    FlutterAppBadger.updateBadgeCount(count);
    streamControllerNotifictionCount.add(count);
  }

  static decreaseNotificationCount() async {
    String? notificationCount =
        await const FlutterSecureStorage().read(key: 'fanappnotificationcount');

    int count = int.parse(notificationCount ?? "0");
    if (count > 0) {
      count = count - 1;
    }
    await const FlutterSecureStorage()
        .write(key: 'fanappnotificationcount', value: count.toString());
    FlutterAppBadger.updateBadgeCount(count);
    streamControllerNotifictionCount.add(count);
  }
}
