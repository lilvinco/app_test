class DashboardTopTrendsTopReleases {
  int? status;
  DataTopReleases? data;

  DashboardTopTrendsTopReleases({this.status, this.data});

  DashboardTopTrendsTopReleases.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataTopReleases.fromJson(json['data']) : null;
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

class DataTopReleases {
  List<TopReleases>? topReleases;

  DataTopReleases({this.topReleases});

  DataTopReleases.fromJson(Map<String, dynamic> json) {
    if (json['top_releases'] != null) {
      topReleases = <TopReleases>[];
      json['top_releases'].forEach((v) {
        topReleases!.add(TopReleases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topReleases != null) {
      data['top_releases'] =
          topReleases!.map((TopReleases v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopReleases {
  String? cover;
  String? title;
  String? subtitle;
  String? total;
  String? change;
  List<Attributes>? attributes;
  int? chartType;
  String? idRelease;

  TopReleases(
      {this.cover,
      this.title,
      this.subtitle,
      this.total,
      this.change,
      this.attributes,
      this.chartType,
      this.idRelease});

  TopReleases.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cover'] = cover;
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
