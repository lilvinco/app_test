import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';

class NavigationService {
  RouteSettings get currentRoute =>
      ModalRoute.of(AppKeys.navigatorKey.currentContext!)!.settings;

  String? get currentRouteName {
    String? currentPath;
    AppKeys.navigatorKey.currentState?.popUntil((Route route) {
      currentPath = route.settings.name;
      return true;
    });

    return currentPath;
  }

  // ignore: lines_longer_than_80_chars
  Future<dynamic> push(Route route) =>
      AppKeys.navigatorKey.currentState!.push(route);

  Future<dynamic> pushReplacement(Route route) =>
      AppKeys.navigatorKey.currentState!.pushReplacement(route);

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) =>
      // ignore: lines_longer_than_80_chars
      AppKeys.navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments}) =>
      AppKeys.navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);

  Future<dynamic> pushNamedAndRemoveUntil(
          String routeName, RoutePredicate predicate, {dynamic arguments}) =>
      AppKeys.navigatorKey.currentState!
          .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  Future<dynamic> pushAndRemoveUntil(Route route, RoutePredicate predicate,
          {dynamic arguments}) =>
      AppKeys.navigatorKey.currentState!.pushAndRemoveUntil(route, predicate);

  void popUntil(RoutePredicate predicate) {
    return AppKeys.navigatorKey.currentState!.popUntil(predicate);
  }

  void pop({dynamic result}) {
    return AppKeys.navigatorKey.currentState!.pop<dynamic>(result);
  }
}
