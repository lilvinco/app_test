import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/constants/routes.dart';
import 'package:igroove_fan_box_one/core/utilities/file_chooser.dart';
import 'package:igroove_fan_box_one/ui/pages/common/error_alert.dart';
import 'package:igroove_fan_box_one/ui/pages/common/warning_alert.dart';
import 'package:igroove_fan_box_one/ui/pages/login/login.dart';
import 'package:igroove_fan_box_one/ui/pages/startup_view.dart';
import 'package:igroove_fan_box_one/ui/widgets/full_media_player_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'pages/home/home_page.dart';
import 'pages/home/tabs/fanbox/fanbox.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.startUp:
      return _pageRoute(settings, StartUpView());
    case AppRoutes.login:
      return _pageRoute(settings, LoginPage());
    case AppRoutes.fanBox:
      final FanBoxParameters parameters =
          settings.arguments as FanBoxParameters;
      return _pageRoute(settings, FanBoxPage(parameters: parameters));
    case AppRoutes.home:
      return _pageRoute(settings, HomePage());
    case AppRoutes.fullMediaPlayerWidget:
      final FullMediaPlayerWidgetParameters? parameters =
          settings.arguments as FullMediaPlayerWidgetParameters?;
      return _slidePageRoute(
          settings, FullMediaPlayerWidget(parameters: parameters));

    case AppRoutes.dropboxChooser:
      final DropboxChooserParameters? parameters =
          settings.arguments as DropboxChooserParameters?;
      return _pageRoute(
        settings,
        DropboxChooser(parameters: parameters),
      );

    case AppRoutes.errorAlert:
      final ErrorAlertParams? parameters =
          settings.arguments as ErrorAlertParams?;
      return _alertRoute(settings, ErrorAlert(parameters: parameters));
    case AppRoutes.warningAlert:
      final WarningAlertParams? parameters =
          settings.arguments as WarningAlertParams?;
      return _alertRoute(settings, WarningAlert(parameters: parameters));
    default:
      return _pageRoute(settings, LoginPage());
  }
}

MaterialPageRoute _pageRoute(RouteSettings settings, Widget widget) {
  return MaterialPageRoute(
    settings: settings,
    builder: (_) => widget,
  );
}

ModalBottomSheetRoute _alertRoute(
  RouteSettings settings,
  Widget widget, {
  bool isDismissible = true,
}) {
  return ModalBottomSheetRoute<void>(
    modalBarrierColor: Colors.black.withOpacity(0.5),
    expanded: false,
    enableDrag: false,
    isDismissible: isDismissible,
    bounce: false,
    settings: settings,
    builder: (_) => widget,
  );
}

PageRouteBuilder _slidePageRoute(RouteSettings settings, Widget widget) {
  return PageRouteBuilder<void>(
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        widget,
    transitionsBuilder: _slideTopTransition,
    settings: settings,
  );
}

SlideTransition _slideTopTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  final Offset begin = const Offset(0.0, 1.0);
  final Offset end = Offset.zero;
  final Curve curve = Curves.ease;

  final Tween<Offset> tween = Tween(begin: begin, end: end);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
}
