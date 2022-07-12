import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';

class FlexibleAppMenuItem {
  String? title;
  String? position;
  String? link;
  FlexibleAppMenuItem({
    this.link,
    this.position,
    this.title,
  });
  FlexibleAppMenuItem.fromJson(Map<String, dynamic> json) {
    String localCode =
        Localizations.localeOf(AppKeys.navigatorKey.currentContext!)
            .languageCode;
    title = localCode == "en"
        ? json['title_en']
        : localCode == "fr"
            ? json['title_fr']
            : json['title_de'];
    position = json['position'];
    link = localCode == "en"
        ? json['link_en']
        : localCode == "fr"
            ? json['link_fr']
            : json['link_de'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['position'] = position;
    data['link'] = link;
    return data;
  }
}
