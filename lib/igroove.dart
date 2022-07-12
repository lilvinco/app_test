import 'package:audio_service/audio_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/app_model.dart';
import 'package:igroove_fan_box_one/provider_setup.dart';
import 'package:igroove_fan_box_one/ui/router.dart';
import 'package:igroove_fan_box_one/ui/widgets/media_player_widget.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'config.dart';

/// Root widget of the app.
///
/// Initializes the app, sets the title, loads localizations,
/// sets the app theme, defines the routes

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class IGroove extends StatelessWidget {
  IGroove() {
    localeSubject = BehaviorSubject<Locale>();
    setLocale();

    AppModel().appSettings.setGeneratedUserId();
  }

  static late BehaviorSubject<Locale> localeSubject;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: AppBuilder(
        builder: (BuildContext context) => StreamBuilder(
          stream: localeSubject.stream,
          builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
            return MaterialApp(
              color: IGrooveTheme.colors.fanBoxBlack,
              debugShowCheckedModeBanner: false,
              navigatorKey: AppKeys.navigatorKey,
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: analytics),
                routeObserver,
              ],
              builder: (BuildContext context, Widget? widget) {
                return Stack(
                  children: [
                    MediaQuery(
                      child: widget!,
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    ),
                    const MediaPlayerWidget(),
                  ],
                );
              },
              title: Configs.APP_NAME,
              theme: Configs.APP_WHITELABEL == true
                  ? IGrooveTheme.custom
                  : IGrooveTheme.light,
              initialRoute: AppRoutes.startUp,
              onGenerateRoute: generateRoute,
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: snapshot.data ?? const Locale("de", 'DE'),
              supportedLocales: [const Locale("de", 'DE')],
            );
          },
        ),
      ),
    );
  }

  static Future setLocale({String? localeCode}) async {
    if (localeCode == null) {
      localeSubject.sink.add(const Locale("de", 'DE'));
    } else {
      await AppModel().translations.getTranslations(lang: localeCode);

      localeSubject.sink.add(Locale(localeCode));
    }

    return true;
  }

  static closeStream() async {
    await localeSubject.close();
  }
}

class AppBuilder extends StatefulWidget {
  final Function(BuildContext)? builder;

  const AppBuilder({Key? key, this.builder}) : super(key: key);

  @override
  AppBuilderState createState() => AppBuilderState();

  static AppBuilderState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
    //aspect: const TypeMatcher<AppBuilderState>());
  }
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder!(context);
  }

  void rebuild() {
    setState(() {});
  }
}
