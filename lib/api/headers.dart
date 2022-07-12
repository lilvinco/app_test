import 'dart:io';

import 'package:igroove_fan_box_one/base/base.dart';

/// Contains header values for Base app Cloud Client.
/// Stores the headers inside static class members, so
///  can be assecced without initializing the Headers class.
class Headers {
  static String? _userAgent;

  /// Value for `Accept` header
  static String get accept {
    return 'application/json';
  }

  /// Value for `Content-Type` header.
  static String? get contentType {
    return DotEnv().env['CLOUD_CONTENT_TYPE'];
  }

  /// Value for `authorization` header.
  static String get authorization {
    return 'Bearer {Auth.token}';
  }

  /// Value for `User-Agent` header
  static String? get userAgent {
    // Create and store the User-Agent header
    _userAgent ??= _userAgentHeader();

    return _userAgent;
  }

  /// Creates and returns header value for `User-Agent` header
  static String _userAgentHeader() {
    // Get the header template from congif
    String headerTemplate = DotEnv().env['HTTP_CLIENT_USER_AGENT']!;

    // Init the EnvInfo class to access device/package info
    EnvInfo envInfo = EnvInfo();

    // Get device and package properties
    String softwareVersion = envInfo.package.version;
    String operatingSystem = Platform.operatingSystem;
    String? operatingSystemVersion = envInfo.device!['systemVersion'];

    /// For iOS this will return the device model in apple specefic format.
    /// e.g. @"iPhone7,1" on iPhone 6 Plus
    /// https://stackoverflow.com/a/28186071/6599667
    String? deviceName = envInfo.device!['utsname.machine:'];

    // For Android some properties are different
    if (Platform.isAndroid) {
      deviceName = envInfo.device!['model'];
      operatingSystemVersion = envInfo.device!['version.release'];
    }

    // Modify the template with platform specific values
    String userAgent = headerTemplate
        .replaceFirst('sv', softwareVersion)
        .replaceFirst('os', operatingSystem)
        .replaceFirst('osv', operatingSystemVersion!)
        .replaceFirst('model', deviceName!);

    return userAgent;
  }
}
