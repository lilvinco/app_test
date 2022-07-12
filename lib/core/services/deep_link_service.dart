import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/widgets/dialog.dart';

class DeepLinkService {
  final UserService userService;

  DeepLinkService({
    required this.userService,
  });

  Future handleDeal(String? dealId) async {
    if (dealId == null || dealId.isEmpty) throw 'No deal id passed';

    final bool authenticated = await _authenticateFirst();
    if (!authenticated) throw 'Must sign in first';
  }

  Future handleMagicCode(String? code) async {
    if (code == null || code.isEmpty) {
      throw 'No magic code found in query params';
    }

    BuildContext context = AppKeys.navigatorKey.currentContext!;
    // MagicCodeResponse response =
    //     await IGrooveAPI().magicCode.checkMagicCode(magicCode: code);

    // if (response.error != null) throw response.error!;

    // final data = response.response.data;

    await Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.login, (Route route) => false);

    // await Navigator.of(context)
    //     .pushNamed(AppRoutes.checkPartnerData, arguments: data);
  }

  Future<bool> _authenticateFirst() async {
    final BuildContext? context = AppKeys.navigatorKey.currentContext;
    final FlutterSecureStorage storage = const FlutterSecureStorage();

    final bool isLoggedIn = await userService.isLoggedIn();
    if (isLoggedIn) {
      return true;
    }

    final String? credentialsSaved = await storage.read(key: 'igrooveissaved');
    if (credentialsSaved != 'yes') {
      throw "User's credentials not saved";
    }

    final String? email = await storage.read(key: 'igrooveusername');
    final String? password = await storage.read(key: 'igroovepassword');

    try {
      await userService.signIn(
        email: email,
        password: password,
      );
      await Navigator.of(AppKeys.navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(AppRoutes.home, (Route e) => false);

      await Future.delayed(const Duration(milliseconds: 1500));

      return true;
    } on DioError catch (e) {
      String errorMessage = e.message;
      await IGrooveDialog(
              AppLocalizations.of(context!)!.generalDialogSorry!, errorMessage)
          .show(context);
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    }

    return false;
  }
}
