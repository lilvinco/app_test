import 'package:igroove_fan_box_one/management/appinfo/appinfo.dart';
import 'package:igroove_fan_box_one/management/appsettings/appsettings.dart';
import 'package:igroove_fan_box_one/management/translations/translation.dart';

/// AppModel is responsible for managing the app state and
///  communicating with Cloud/API, DB and UI layers.
/// AppModel is based on singleton pattern to have single instance
/// accross the app.
class AppModel {
  static AppModel? _singleton;

  int currentPageIndex = 0;
  int currentTabMostAskedQuestions = 0;

  factory AppModel() {
    _singleton ??= AppModel._internal();

    return _singleton!;
  }
  AppInfoManagement appinfo = AppInfoManagement();
  AppSettingsManagement appSettings = AppSettingsManagement();
  Translations translations = Translations();
  // Private internal constructor.
  AppModel._internal();
}
