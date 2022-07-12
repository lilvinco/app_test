import 'dart:io';

import 'package:local_auth/local_auth.dart';

class DeviceAuth {
  static DeviceAuth? _deviceAuth;
  late LocalAuthentication _scanner;
  bool isFingerprintAvailable = false;
  bool isFaceIdAvailable = false;

  factory DeviceAuth() {
    _deviceAuth ??= DeviceAuth._internal();

    return _deviceAuth!;
  }

  DeviceAuth._internal();

  /// Inits the Biometric authentication plugin and sets the available
  /// Biometric authentication types.
  /// To get available types checks for `isFingerprintAval` and `isFaceIdAval`
  /// properties.
  Future<void> init() async {
    // Init the plugin
    _scanner = LocalAuthentication();

    // Get available types
    List<BiometricType> availableBiometrics =
        await _scanner.getAvailableBiometrics();

    // Set available types of each platform
    if (Platform.isIOS) {
      isFingerprintAvailable =
          availableBiometrics.contains(BiometricType.fingerprint);
      isFaceIdAvailable = availableBiometrics.contains(BiometricType.face);
    } else if (Platform.isAndroid) {
      // For Android only fingerprint is available
      isFingerprintAvailable =
          availableBiometrics.contains(BiometricType.fingerprint);
    }
  }

  /// Authenticates the user with biometrics available on the device.
  Future<bool> authenticate({required String reason}) async {
    // Try authenticate only when Biometric scaner is available
    if (isFingerprintAvailable || isFaceIdAvailable) {
      bool didAuthenticate = false;
      // Authenticate with scanner
      try {
        didAuthenticate = await _scanner.authenticate(
            biometricOnly: true, localizedReason: reason);
      } catch (e, stacktrace) {
        print(e.toString());
        print(stacktrace.toString());
      }

      return didAuthenticate;
    }

    return false;
  }
}
