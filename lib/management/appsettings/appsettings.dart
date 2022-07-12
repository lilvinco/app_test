import 'package:igroove_fan_box_one/model/app_settings.dart';
import 'package:uuid/uuid.dart';

class AppSettingsManagement {
  AppSettings? _appSettings;
  AppSettings? get appSettingsData => _appSettings;

  String? _generatedUserId;
  String? get generatedUserId => _generatedUserId;

  setAppSettings(AppSettings data) {
    _appSettings = data;
  }

  setGeneratedUserId() {
    Uuid uuid = const Uuid();
    _generatedUserId ??= uuid.v4();
  }
}
