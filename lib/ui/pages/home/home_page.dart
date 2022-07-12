import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/audio_handler.dart';
import 'package:igroove_fan_box_one/core/services/media_player_service.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/app_model.dart';
import 'package:igroove_fan_box_one/management/push_navigate_service.dart';
import 'package:igroove_fan_box_one/ui/pages/home/tabs/fanbox/fanbox_overview.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _childrenTabs;

  MyAudioHandler mediaService = MyAudioHandler();
  List<String> tabNames = [
    'fanboxes',
  ];
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    _initTabs();

    MyAudioHandler.streamControllerHomePage.stream.listen((tab) {
      print("PlayerStatus => ${tab.toString()}");
      AppModel().currentTabMostAskedQuestions = 0;
      onTabTapped(tab);
    });

    PushNavigationService.currentPageName = tabNames[0];
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Stack(
      children: <Widget>[
        WillPopScope(
          onWillPop: (() async {
            return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      backgroundColor: const Color(0XFF4C4C4C),
                      title: Text(
                        AppLocalizations.of(context)!.exitAppTitle,
                        style: TextStyle(
                          color: IGrooveTheme.colors.white,
                        ),
                      ),
                      content: Text(
                        AppLocalizations.of(context)!.exitAppContent,
                        style: TextStyle(
                          color: IGrooveTheme.colors.white,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            AppLocalizations.of(context)!.exitAppCancel,
                            style: TextStyle(
                              color: IGrooveTheme.colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            AppLocalizations.of(context)!.exitAppConfirm,
                            style: TextStyle(
                              color: IGrooveTheme.colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            SystemNavigator.pop();
                          },
                        ),
                      ],
                    ));
          }),
          child: Material(
            color: IGrooveTheme.colors.headerColor,
            child: Scaffold(
              backgroundColor: IGrooveTheme.colors.headerColor,
              key: AppKeys.homeScreen,
              body: body(context),
              bottomNavigationBar: bottomNavBar(),
            ),
          ),
        ),
      ],
    );
  }

  Widget body(context) {
    return _childrenTabs[0];
  }

  Widget bottomNavBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(width: 1, color: IGrooveTheme.colors.black4!))),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: IGrooveTheme.colors.fanBoxBlack,
        onTap: onTabTapped,
        currentIndex: 0,
        selectedLabelStyle: TextStyle(
            fontSize: 10,
            color: IGrooveTheme.colors.white,
            letterSpacing: 0,
            fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
            fontSize: 10,
            color: IGrooveTheme.colors.white,
            letterSpacing: 0,
            fontWeight: FontWeight.w400),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: IGrooveTheme.colors.white,
        unselectedItemColor: IGrooveTheme.colors.white!.withOpacity(0.75),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 10),
              child: SvgPicture.asset(
                IGrooveAssets.svgBlockIcon,
                width: 18,
                height: 21,
                color: IGrooveTheme.colors.primary,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 10),
              child: SvgPicture.asset(
                IGrooveAssets.svgBlockIcon,
                width: 18,
                height: 21,
                color: IGrooveTheme.colors.secondary,
              ),
            ),
            label: "Music",
          ),
          const BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 8, top: 10),
              child: SizedBox(),
            ),
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8, top: 10),
              child: SizedBox(),
            ),
            label: "",
          ),
        ],
      ),
    );
  }

  void _initTabs() {
    _childrenTabs = [
      FanBoxOverviewPage(),
      FanBoxOverviewPage(),
    ];
  }

  onTabTapped(int index) async {
    PushNavigationService.currentPageName = tabNames[0];
    MyAudioHandler.setYPositionOfWidget(100);
    await AppModel().translations.getTranslations(lang: 'de');

    if (mounted) {
      setState(() {
        AppModel().currentPageIndex = index;
      });
    }
  }
}
