class DashboardAudience {
  int? status;
  List<Data>? data;

  List<String>? categories;
  List<String>? values;
  GenderData? genderData;
  DeviceData? deviceData;
  TierData? tierData;

  DashboardAudience({
    this.status,
    this.data,
    this.categories,
    this.values,
    this.genderData,
    this.deviceData,
    this.tierData,
  });

  DashboardAudience.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] is! Map) {
      return;
    }

    Map<dynamic, dynamic> data = json['data'];

    categories = List.from(data['audienceData']['categories'])
        .map((e) => e.toString())
        .toList();
    values = List.from(data['audienceData']['values'])
        .map((e) => e.toString())
        .toList();
    genderData = GenderData.fromJson(data['genderData']);
    deviceData = DeviceData.fromJson(data['deviceData']);
    tierData = TierData.fromJson(data['tierData']);
  }
}

class Data {
  String? title;
  int? percent;
  int? free;
  int? premium;
  int? desktop;
  int? mobile;
  int? total;
  List<Gender>? gender;

  Data({this.title, this.percent, this.gender});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    percent = json['percent'];
    free = json['free'];
    premium = json['premium'];
    desktop = json['desktop'];
    mobile = json['mobile'];
    total = json['total'];
    if (json['gender'] != null) {
      gender = <Gender>[];
      json['gender'].forEach((v) {
        gender!.add(Gender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['percent'] = percent;
    data['free'] = free;
    data['premium'] = premium;
    data['desktop'] = desktop;
    data['mobile'] = mobile;
    data['total'] = total;
    if (gender != null) {
      data['gender'] = gender!.map((Gender v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Data{title: $title, '
        'percent: $percent, free: '
        '$free, premium: $premium, '
        'desktop: $desktop, mobile: '
        '$mobile, total: $total, '
        'gender: $gender}';
  }
}

class Gender {
  String? title;
  int? percent;

  Gender({this.title, this.percent});

  Gender.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['percent'] = percent;
    return data;
  }
}

class GenderData {
  String? male;
  String? female;

  GenderData({this.male, this.female});

  GenderData.fromJson(Map<String, dynamic> json) {
    male = json['male'].toString();
    female = json['female'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['male'] = male;
    data['female'] = female;
    return data;
  }
}

class DeviceData {
  String? mobile;
  String? desktop;

  DeviceData({
    this.mobile,
    this.desktop,
  });

  DeviceData.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'].toString();
    desktop = json['desktop'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile'] = mobile;
    data['desktop'] = desktop;
    return data;
  }
}

class TierData {
  String? free;
  String? premium;

  TierData({
    this.free,
    this.premium,
  });

  TierData.fromJson(Map<String, dynamic> json) {
    free = json['free'].toString();
    premium = json['premium'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['free'] = free;
    data['premium'] = premium;
    return data;
  }
}
