import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:igroove_fan_box_one/api/auth.dart';
import 'package:igroove_fan_box_one/api/igroove_api.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/config.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/helpers/utils.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/app_model.dart';
import 'package:igroove_fan_box_one/management/push_navigate_service.dart';
import 'package:igroove_fan_box_one/model/app_settings.dart';
import 'package:igroove_fan_box_one/page_notifier.dart';
import 'package:igroove_fan_box_one/ui/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MorePage extends StatefulWidget {
  MorePage();

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IGrooveAppBarWidget.fanBoxAppBar(showNotifications: true)
          as PreferredSizeWidget?,
      body: body(),
      backgroundColor: IGrooveTheme.colors.black2,
    );
  }

  bool isClicked = false;

  body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(AppLocalizations.of(context)!.moreAppBarHeader!,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: IGrooveTheme.colors.white!,
                  letterSpacing: -1.4,
                  height: 35 / 35)),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: IGrooveTheme.colors.white!.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                if (!isClicked) {
                  isClicked = true;
                  await Auth.check();
                  await Navigator.of(context).pushNamed(AppRoutes.profile);
                  isClicked = false;
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        IGrooveAssets.svgUserMoreIcon,
                        width: 20,
                        height: 22,
                        color: IGrooveTheme.colors.white!.withOpacity(0.75),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Text(
                        AppLocalizations.of(context)!.moreEditProfileButton!,
                        style: TextStyle(
                          color: IGrooveTheme.colors.white,
                          fontSize: 20,
                          height: 24 / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    IGrooveAssets.svgArrowMoreIcon,
                    width: 7,
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: IGrooveTheme.colors.white!.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                if (!isClicked) {
                  isClicked = true;
                  await Auth.check();
                  PushNavigationService.currentPageName = "support";
                  await Navigator.of(context).pushNamed(AppRoutes.support);
                  PushNavigationService.currentPageName = 'more';
                  isClicked = false;
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        IGrooveAssets.svgHeadphonesMicIcon,
                        width: 20,
                        height: 22,
                        color: IGrooveTheme.colors.white!.withOpacity(0.75),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Text(
                        AppLocalizations.of(context)!.moreSupportButton!,
                        style: TextStyle(
                          color: IGrooveTheme.colors.white,
                          fontSize: 20,
                          height: 24 / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    IGrooveAssets.svgArrowMoreIcon,
                    width: 7,
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: IGrooveTheme.colors.white!.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                PlayerStateManager.audioPlayerReset();
                PlayerStateManager.setShowSmallPlayer(false);
                // reset api
                Dio client = Provider.of(context, listen: false);
                client.options.baseUrl =
                    'https://' + Configs.cloudURL + Configs.CLOUD_PATH;
                IGrooveAPI().reset();

                await Future.delayed(const Duration(milliseconds: 200), () {
                  AppModel().appSettings.setAppSettings(AppSettings(
                      showFeedbackButton: false, showRevShare: false));
                });

                AppModel().currentPageIndex = 0;
                await const FlutterSecureStorage()
                    .delete(key: 'igrooveusername');
                await const FlutterSecureStorage()
                    .delete(key: 'igroovepassword');
                await const FlutterSecureStorage()
                    .delete(key: 'igrooveissaved');
                await Utils.setNotificationCount(count: 0);
                await const FlutterSecureStorage()
                    .delete(key: 'fanappnotificationcount');

                await Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.login)
                    .then((Object? v) {
                  AppModel().appSettings.setAppSettings(AppSettings(
                      showFeedbackButton: false, showRevShare: false));
                  AppModel().appSettings.setAppSettings(AppSettings(
                      showFeedbackButton: false, showRevShare: false));
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const SizedBox(),
                      Text(
                        AppLocalizations.of(context)!.moreLogoutButton!,
                        style: TextStyle(
                          color: IGrooveTheme.colors.primary,
                          fontSize: 20,
                          height: 24 / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        _version(),
        _lastSentence(),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _version() {
    return Container(
      height: 54,
      child: Center(
        child: Text(
          "VERSION ${EnvInfo().package.version}"
          " (${EnvInfo().package.buildNumber})",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: IGrooveTheme.colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _lastSentence() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations().moreSectionTermsPartOne,
                  style: const TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: AppLocalizations().moreSectionTermsPartTwo,
                  style: TextStyle(
                      color: IGrooveTheme.colors.white!.withOpacity(0.7)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      PushNavigationService.currentPageName = "openUrl";

                      PushNavigationService.currentPageName = 'more_page';
                    },
                ),
                TextSpan(
                  text: AppLocalizations().moreSectionTermsPartThree,
                  style: const TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: AppLocalizations().moreSectionTermsPartFour,
                  style: TextStyle(
                      color: IGrooveTheme.colors.white!.withOpacity(0.7)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      PushNavigationService.currentPageName = "openUrl";

                      PushNavigationService.currentPageName = 'more_page';
                    },
                ),
                TextSpan(
                  text: AppLocalizations().moreSectionTermsPartFive,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            )));
  }
}
