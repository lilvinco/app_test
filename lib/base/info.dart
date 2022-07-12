import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

/// Class provides information about runing device/platform
/// After the first time initialized, the `init` method should
///  be called on instance.
/// To get the device info use `device` getter, which is
///  platform specific and provided as Map<dynamic, dynamic>object.
/// To get package info, such as build number and build code,
///  use `package` getter.
class EnvInfo {
  /// Singleton instance of `EnvInfo` class
  static EnvInfo? _envInfo;

  // Init the device info plugin
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// Contains properties of device on which the app is runing on
  Map<String, dynamic>? device = <String, dynamic>{};

  /// Contains package info properties
  PackageInfo package = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  /// Used to initiate and save the instance
  ///  after the class is initialized first time
  factory EnvInfo() {
    _envInfo ??= EnvInfo._internal();

    return _envInfo!;
  }

  /// Used from factory contructor and
  ///  not available outside of class
  EnvInfo._internal();

  /// Used to initiate and save the `device`
  /// and `package` info.
  /// The properties will be accessible only after
  ///  `init` will be done.
  Future<void> init() async {
    device = await _getDeviceInfo();
    package = await _getPackageInfo();
  }

  /// Get the package info from [PackageInfo] class
  Future<PackageInfo> _getPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    return info;
  }

  /// Checks the Platform and gets device info for runing platform
  Future<Map<String, dynamic>?> _getDeviceInfo() async {
    Map<String, dynamic>? deviceData;

    // Catch the error if somehow the device info is not accessible
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    return deviceData;
  }

  /// Creates key/value Map<dynamic, dynamic>for Android specific info
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'uniqueID': build.androidId,
    };
  }

  /// Creates key/value Map<dynamic, dynamic>for iOS specific info
  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'uniqueID': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
