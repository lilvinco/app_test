import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:igroove_fan_box_one/core/networking/api.dart';
import 'package:igroove_fan_box_one/core/services/deep_link_service.dart';
import 'package:igroove_fan_box_one/core/services/general_service.dart';
import 'package:igroove_fan_box_one/core/services/navigation_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/services/dynamic_links_service.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => Client.init()),
  Provider(create: (_) => NavigationService()),
  Provider(create: (_) => const FlutterSecureStorage()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider2<Dio, FlutterSecureStorage, UserService>(
    update: (_, Dio dio, FlutterSecureStorage flutterSecureStorage,
            UserService? userService) =>
        UserService(client: dio, flutterSecureStorage: flutterSecureStorage),
  ),
  ProxyProvider<Dio, GeneralService>(
    update: (_, Dio dio, GeneralService? generalService) =>
        GeneralService(client: dio),
  ),
  ProxyProvider<UserService, DeepLinkService>(
    update: (_, UserService userService, DeepLinkService? deepLinkService) =>
        DeepLinkService(userService: userService),
  ),
  ProxyProvider<DeepLinkService, DynamicLinksService>(
    update: (BuildContext context, DeepLinkService deepLinkService,
            DynamicLinksService? dynamicLinksService) =>
        DynamicLinksService(deepLinkService: deepLinkService),
  ),
];

List<SingleChildWidget> uiConsumableProviders = [];
