class DashboardTopTrendsTopCountries {
  int? status;
  DataTopCountries? data;

  DashboardTopTrendsTopCountries({this.status, this.data});

  DashboardTopTrendsTopCountries.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? DataTopCountries.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataTopCountries {
  List<TopCountries>? topCountries;

  DataTopCountries({this.topCountries});

  DataTopCountries.fromJson(Map<String, dynamic> json) {
    if (json['top_countries'] != null) {
      topCountries = <TopCountries>[];
      json['top_countries'].forEach((v) {
        topCountries!.add(TopCountries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topCountries != null) {
      data['top_countries'] =
          topCountries!.map((TopCountries v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopCountries {
  String? title;
  String? subtitle;
  String? total;
  String? change;
  List<Attributes>? attributes;
  int? chartType;
  String? idRelease;
  String? countryCode;

  TopCountries(
      {this.title,
      this.subtitle,
      this.total,
      this.change,
      this.attributes,
      this.chartType,
      this.idRelease,
      this.countryCode});

  TopCountries.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    total = json['total'];
    change = json['change'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    chartType = json['chart_type'];
    idRelease = json['idRelease'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['total'] = total;
    data['change'] = change;
    if (attributes != null) {
      data['attributes'] =
          attributes!.map((Attributes v) => v.toJson()).toList();
    }
    data['chart_type'] = chartType;
    data['idRelease'] = idRelease;
    data['countryCode'] = countryCode;
    return data;
  }
}

class Attributes {
  String? name;
  String? value;
  String? type;

  Attributes({this.name, this.value, this.type});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['type'] = type;
    return data;
  }
}
