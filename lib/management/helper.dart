import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/config.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/download_file.dart';
import 'package:igroove_fan_box_one/model/assets_model.dart';
import 'package:igroove_fan_box_one/ui/pages/common/error_alert.dart';
import 'package:igroove_fan_box_one/ui/widgets/download_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Widget indicatorWidget() {
  return Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 45,
        width: 45,
        child: CircularProgressIndicator(
          strokeWidth: 5,
          valueColor: AlwaysStoppedAnimation<Color?>(
            IGrooveTheme.colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget loadingWidget() {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      width: 70,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color?>(
          IGrooveTheme.colors.white,
        ),
      ),
    ),
  );
}

bool isPhoneVerificationOpen() {
  if (UserService.userData!.payload!.user!.phoneNumberVerified == false) {
    unawaited(
      Navigator.pushNamed(
        AppKeys.navigatorKey.currentState!.context,
        AppRoutes.errorAlert,
        arguments: ErrorAlertParams(
          title:
              AppLocalizations.of(AppKeys.navigatorKey.currentState!.context)!
                  .generalDialogSorry!,
          message:
              AppLocalizations.of(AppKeys.navigatorKey.currentState!.context)!
                  .generalPhoneNotVerified,
        ),
      ),
    );
    return true;
  } else {
    return false;
  }
}

getUpdatedAsset({required String assetID}) async {
  UserService userService =
      Provider.of(AppKeys.navigatorKey.currentState!.context, listen: false);

  try {
    AssetsResponse response = await userService.getAsset(assetID: assetID);

    if (response.status == 1) {
      if (response.assetList == null) {
        return;
      }
      return response.assetList!.first;
    } else {
      await Navigator.pushNamed(
          AppKeys.navigatorKey.currentState!.context, AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
              title: AppLocalizations.of(
                      AppKeys.navigatorKey.currentState!.context)!
                  .generalDialogSorry!,
              message: AppLocalizations.of(
                      AppKeys.navigatorKey.currentState!.context)!
                  .generalDialogSorryText!));
    }
  } on DioError catch (e) {
    print(e.toString());

    await Navigator.pushNamed(
        AppKeys.navigatorKey.currentState!.context, AppRoutes.errorAlert,
        arguments: ErrorAlertParams(
            title:
                AppLocalizations.of(AppKeys.navigatorKey.currentState!.context)!
                    .generalDialogSorry!,
            message: e.toString()));
  } catch (e, stacktrace) {
    print(e.toString());
    print(stacktrace.toString());
  } finally {}
}

Future<dynamic> setAssetLike({required String assetID}) async {
  UserService userService =
      Provider.of(AppKeys.navigatorKey.currentState!.context, listen: false);
  await userService.addLikeToAsset(assetID: assetID);
}

Future<String>? getPathOfFile({required String filename}) async {
  String? path = await const FlutterSecureStorage().read(key: filename);
  return path.toString();
}

String getUrlParameters() {
  return "?token=${Auth.authToken}&"
      "device_id=${EnvInfo().device!['uniqueID']}&"
      "app_instance_token=${Configs.APP_INSTANCE_TOKEN}";
}

Future<String> createFilePath({required String filename}) async {
  Directory directory;
  directory = await getApplicationDocumentsDirectory();
  String filePath = directory.path + "/" + filename;
  return filePath;
}

Future<bool> isFileExistInSecureStorage({required String filename}) async {
  String? path = await const FlutterSecureStorage().read(key: filename);
  return path == null ? false : true;
}

Future<bool> isFileExistOnDevice({required String filename}) async {
  String filePath = await createFilePath(filename: filename);
  bool fileExistOnDevice = await File(filePath).exists();
  return fileExistOnDevice;
}

Future<bool> isFileExistAndAvailable({required String filename}) async {
  bool fileExistInSecureStorage =
      await isFileExistInSecureStorage(filename: filename);
  bool fileExistOnDevice = await isFileExistOnDevice(filename: filename);

  if (fileExistInSecureStorage && fileExistOnDevice) {
    return true;
  } else {
    return false;
  }
}

String singular(
    {required int raw,
    required String formatted,
    required String singular,
    required String plural}) {
  if (raw == 1) {
    return "$formatted $singular";
  } else {
    return "$formatted $plural";
  }
}

Future<dynamic> downloadFile(
    {required String filename,
    required String url,
    int total = 1,
    int current = 1,
    bool showProgress = true,
    String title = ""}) async {
  final DownloadFileService _downloadFileService = DownloadFileService();
  PermissionStatus storageStatus = await Permission.storage.status;

  if (storageStatus == PermissionStatus.denied ||
      storageStatus == PermissionStatus.restricted) {
    PermissionStatus storageStatus = await Permission.storage.status;

    storageStatus = await Permission.storage.request();

    if (storageStatus == PermissionStatus.denied) {
      unawaited(Navigator.pushNamed(
          AppKeys.navigatorKey.currentState!.context, AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
              title: AppLocalizations.of(
                      AppKeys.navigatorKey.currentState!.context)!
                  .generalNoPermissionGrantedTitle!,
              message: AppLocalizations.of(
                      AppKeys.navigatorKey.currentState!.context)!
                  .generalNoPermissionGrantedText!)));
    }
  } else {
    String filePath = await createFilePath(filename: filename);

    if (await isFileExistAndAvailable(filename: filename)) {
      return;
    }
    if (showProgress) {
      unawaited(showGeneralDialog(
        context: AppKeys.navigatorKey.currentState!.context,
        barrierDismissible: _downloadFileService.isDownloadCompleted,
        barrierColor: IGrooveTheme.colors.black!.withOpacity(0.5),
        barrierLabel: "de",
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return FadeTransition(
            alwaysIncludeSemantics: true,
            opacity: animation as Animation<double>,
            child: ScaleTransition(
              scale: animation,
              child: DownloadDialog(_downloadFileService.percentSender,
                  current: current, total: total, title: title),
            ),
          );
        },
      ));
    }

    String preparedURL = url + getUrlParameters();

    print("download url " + preparedURL);

    String? errorMessage = await _downloadFileService.downloadFile(
        savePath: filePath, downloadURL: preparedURL, fileID: filename);
    if (showProgress) {
      Navigator.of(AppKeys.navigatorKey.currentState!.context).pop();
    }

    if (errorMessage == null) {
      print("Downloaded");
      print("Saved File \"$filename\" at " + filePath);
      return true;
    } else {
      unawaited(
        Navigator.pushNamed(
          AppKeys.navigatorKey.currentState!.context,
          AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
            title:
                AppLocalizations.of(AppKeys.navigatorKey.currentState!.context)!
                    .generalDialogSorry,
            message: errorMessage.toString(),
          ),
        ),
      );
    }
  }
}
