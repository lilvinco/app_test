class DashboardTopTrendsTopArtists {
  int? status;
  DataTopArtists? data;

  DashboardTopTrendsTopArtists({this.status, this.data});

  DashboardTopTrendsTopArtists.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataTopArtists.fromJson(json['data']) : null;
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

class DataTopArtists {
  List<TopArtists>? topArtists;

  DataTopArtists({this.topArtists});

  DataTopArtists.fromJson(Map<String, dynamic> json) {
    if (json['top_artists'] != null) {
      topArtists = <TopArtists>[];
      json['top_artists'].forEach((v) {
        topArtists!.add(TopArtists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topArtists != null) {
      data['top_artists'] =
          topArtists!.map((TopArtists v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopArtists {
  String? title;
  String? cover;
  String? subtitle;
  String? total;
  String? change;
  List<Attributes>? attributes;
  String? chartType;
  String? idRelease;

  TopArtists(
      {this.title,
      this.cover,
      this.subtitle,
      this.total,
      this.change,
      this.attributes,
      this.chartType,
      this.idRelease});

  TopArtists.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cover = json['cover'];
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
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['cover'] = cover;
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
