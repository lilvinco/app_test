import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/core/services/deep_link_service.dart';
import 'package:igroove_fan_box_one/helpers/exceptions.dart';

class DynamicLinksService {
  DynamicLinksService({
    required DeepLinkService deepLinkService,
  }) : _deepLinkService = deepLinkService;

  final DeepLinkService _deepLinkService;

  Future<void> initialize() async {
    final BuildContext? context = AppKeys.navigatorKey.currentContext;
    // await Navigator.pushNamedAndRemoveUntil(
    // context!, AppRoutes.login, (Route<dynamic> route) => false);

    //TODO: Check if dynamic links is still working after commenting this

    // FirebaseDynamicLinks.instance.onLink(
    //     onSuccess: (PendingDynamicLinkData dynamicLink) async {
    //   final Uri deepLink = dynamicLink?.link;

    //   if (deepLink != null) {
    //     await process(
    //       params: deepLink?.queryParameters,
    //       deepLink: deepLink,
    //     );
    //   }
    // }, onError: (OnLinkErrorException e) async {
    //   print('onLinkError');
    //   print(e.message);
    // });

    // final PendingDynamicLinkData? data =
    //     await FirebaseDynamicLinks.instance.getInitialLink();

    // Uri? deepLink = data?.link;
    // deepLink = null;

    // if (deepLink != null) {
    //   await process(
    //     params: deepLink.queryParameters,
    //     deepLink: deepLink,
    //   );
    // } else {
    if (!await isAutoLogInActivated()) {
      Navigator.of(context!).pop();
    }

    // await Navigator.pushNamedAndRemoveUntil(
    //     context!, AppRoutes.login, (Route<dynamic> route) => false);
    // }
  }

  Future<bool> isAutoLogInActivated() async {
    final FlutterSecureStorage _storage = const FlutterSecureStorage();

    String? userCredentialIsSaved = await _storage.read(key: 'igrooveissaved');
    String email = "";
    String password = "";
    if (userCredentialIsSaved == 'yes') {
      email = await (_storage.read(key: 'igrooveusername')) ?? '';
      password = await (_storage.read(key: 'igroovepassword')) ?? '';
    }

    bool emailValid = RegExp(RegularExpressions.email).hasMatch(email);
    if (email != "" && password != "" && emailValid) {
      return true;
    }
    return false;
  }

  Future<void> fromUrl({
    required BuildContext context,
    required String link,
  }) async {
    final Uri uri = Uri.tryParse(link)!;

    //final Map<String, String> params = uri?.queryParameters;

    if (uri.hasEmptyPath) {
      throw CustomException('Invalid url');
    }

    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getDynamicLink(uri);

    final Uri? deepLink = data?.link;
    if (deepLink == null) {
      throw CustomException('Invalid deep link url');
    }
    final Map<String, String> params = deepLink.queryParameters;

    await process(deepLink: deepLink, params: params);
  }

  Future<void> process({
    required Uri deepLink,
    Map<String, String>? params,
  }) async {
    switch (deepLink.path) {
      case '/deals':
        final String? dealId = params!['idRelease'];
        await _deepLinkService.handleDeal(dealId);
        break;
      case '/magiccode':
        final String? code = params!['code'];
        await _deepLinkService.handleMagicCode(code);
        break;
    }
  }
}
