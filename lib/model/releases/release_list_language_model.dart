class ReleaseListLanguageModel {
  int? status;
  Payload? payload;

  ReleaseListLanguageModel({this.status, this.payload});

  ReleaseListLanguageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  List<Languages>? languages;

  Payload({this.languages});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (languages != null) {
      data['languages'] = languages!.map((Languages v) => v.toJson()).toList();
    }
    return data;
  }
}

class Languages {
  String? code;
  String? codeIso3;
  String? label;
  int? defaultLanguage;

  Languages({this.code, this.codeIso3, this.label, this.defaultLanguage});

  Languages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeIso3 = json['code_iso3'];
    label = json['label'];
    defaultLanguage = json['defaultLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['code_iso3'] = codeIso3;
    data['label'] = label;
    data['defaultLanguage'] = defaultLanguage;
    return data;
  }
}
