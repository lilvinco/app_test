class DashboardTopTrendsTopStores {
  int? status;
  DataTopStores? data;

  DashboardTopTrendsTopStores({this.status, this.data});

  DashboardTopTrendsTopStores.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataTopStores.fromJson(json['data']) : null;
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

class DataTopStores {
  List<TopStores>? topStores;

  DataTopStores({this.topStores});

  DataTopStores.fromJson(Map<String, dynamic> json) {
    if (json['top_stores'] != null) {
      topStores = <TopStores>[];
      json['top_stores'].forEach((v) {
        topStores!.add(TopStores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topStores != null) {
      data['top_stores'] = topStores!.map((TopStores v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopStores {
  String? title;
  String? subtitle;
  String? total;
  String? change;
  List<Attributes>? attributes;
  int? chartType;
  String? idRelease;

  TopStores(
      {this.title,
      this.subtitle,
      this.total,
      this.change,
      this.attributes,
      this.chartType,
      this.idRelease});

  TopStores.fromJson(Map<String, dynamic> json) {
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
