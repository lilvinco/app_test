import 'package:igroove_fan_box_one/management/app_model.dart';

class IntlServer {
  static String? message(
    String? name,
  ) =>
      _message(
        name,
      );

  static String? _message(
    String? name,
  ) {
    Map<String, String> translationData = AppModel().translations.translations!;
// print("$name --------------  ${translationData[name]} ");
    return translationData[name!] == "" ? null : translationData[name];
  }
}
