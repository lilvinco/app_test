class DashboardTopTrendsTopSongs {
  int? status;
  DataTopSongs? data;

  DashboardTopTrendsTopSongs({this.status, this.data});

  DashboardTopTrendsTopSongs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataTopSongs.fromJson(json['data']) : null;
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

class DataTopSongs {
  List<TopSongs>? topSongs;

  DataTopSongs({this.topSongs});

  DataTopSongs.fromJson(Map<String, dynamic> json) {
    if (json['top_songs'] != null) {
      topSongs = <TopSongs>[];
      json['top_songs'].forEach((v) {
        topSongs!.add(TopSongs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topSongs != null) {
      data['top_songs'] = topSongs!.map((TopSongs v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopSongs {
  String? title;
  String? subtitle;
  String? total;
  String? change;
  List<Attributes>? attributes;
  int? chartType;
  String? idRelease;
  String? cover;

  TopSongs(
      {this.title,
      this.subtitle,
      this.total,
      this.change,
      this.attributes,
      this.chartType,
      this.idRelease,
      this.cover});

  TopSongs.fromJson(Map<String, dynamic> json) {
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
    cover = json['cover'];
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
    data['cover'] = cover;
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
