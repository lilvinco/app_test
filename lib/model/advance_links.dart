import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';

class AdvanceLinks {
  String? title;
  String? link;

  AdvanceLinks({this.title, this.link});

  AdvanceLinks.fromJson(Map<String, dynamic>? json) {
    String localCode =
        Localizations.localeOf(AppKeys.navigatorKey.currentContext!)
            .languageCode;
    title = localCode == "en"
        ? json!['title_en']
        : localCode == "fr"
            ? json!['title_fr']
            : json!['title_de'];
    link = localCode == "en"
        ? json['link_en']
        : localCode == "fr"
            ? json['link_fr']
            : json['link_de'];
  }
}
