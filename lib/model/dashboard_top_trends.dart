class DashboardTopTrends {
  int? status;
  Data? data;

  DashboardTopTrends({this.status, this.data});

  DashboardTopTrends.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  List<TopReleases>? topReleases;
  List<TopSongs>? topSongs;
  List<TopArtists>? topArtists;
  List<TopStores>? topStores;
  List<TopCountries>? topCountries;

  Data(
      {this.topReleases,
      this.topSongs,
      this.topArtists,
      this.topStores,
      this.topCountries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['top_releases'] != null) {
      topReleases = <TopReleases>[];
      json['top_releases'].forEach((v) {
        topReleases!.add(TopReleases.fromJson(v));
      });
    }
    if (json['top_songs'] != null) {
      topSongs = <TopSongs>[];
      json['top_songs'].forEach((v) {
        topSongs!.add(TopSongs.fromJson(v));
      });
    }
    if (json['top_artists'] != null) {
      topArtists = <TopArtists>[];
      json['top_artists'].forEach((v) {
        topArtists!.add(TopArtists.fromJson(v));
      });
    }
    if (json['top_stores'] != null) {
      topStores = <TopStores>[];
      json['top_stores'].forEach((v) {
        topStores!.add(TopStores.fromJson(v));
      });
    }
    if (json['top_countries'] != null) {
      topCountries = <TopCountries>[];
      json['top_countries'].forEach((v) {
        topCountries!.add(TopCountries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topReleases != null) {
      data['top_releases'] =
          topReleases!.map((TopReleases v) => v.toJson()).toList();
    }
    if (topSongs != null) {
      data['top_songs'] = topSongs!.map((TopSongs v) => v.toJson()).toList();
    }
    if (topArtists != null) {
      data['top_artists'] =
          topArtists!.map((TopArtists v) => v.toJson()).toList();
    }
    if (topStores != null) {
      data['top_stores'] = topStores!.map((TopStores v) => v.toJson()).toList();
    }
    if (topCountries != null) {
      data['top_countries'] =
          topCountries!.map((TopCountries v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopReleases {
  String? title;
  String? subtitle;
  String? total;
  String? change;
  List<Attributes>? attributes;
  int? chartType;
  String? idRelease;
  String? cover;

  TopReleases(
      {this.title,
      this.subtitle,
      this.total,
      this.change,
      this.attributes,
      this.chartType,
      this.idRelease,
      this.cover});

  TopReleases.fromJson(Map<String, dynamic> json) {
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

class TopArtists {
  String? title;
  String? subtitle;
  String? total;
  String? change;
  List<Attributes>? attributes;
  String? chartType;
  String? idRelease;

  TopArtists(
      {this.title,
      this.subtitle,
      this.total,
      this.change,
      this.attributes,
      this.chartType,
      this.idRelease});

  TopArtists.fromJson(Map<String, dynamic> json) {
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

class TopSong {
  List<TopSongs>? topSongs;

  TopSong({this.topSongs});

  TopSong.fromJson(Map<String, dynamic> json) {
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
  List<AttributesTopSongs>? attributes;
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
      attributes = <AttributesTopSongs>[];
      json['attributes'].forEach((v) {
        attributes!.add(AttributesTopSongs.fromJson(v));
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
          attributes!.map((AttributesTopSongs v) => v.toJson()).toList();
    }
    data['chart_type'] = chartType;
    data['idRelease'] = idRelease;
    data['cover'] = cover;
    return data;
  }
}

class AttributesTopSongs {
  String? name;
  String? value;
  String? type;

  AttributesTopSongs({this.name, this.value, this.type});

  AttributesTopSongs.fromJson(Map<String, dynamic> json) {
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

class TopCountry {
  List<TopCountries>? topCountries;

  TopCountry({this.topCountries});

  TopCountry.fromJson(Map<String, dynamic> json) {
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
  List<AttributesTopCountries>? attributes;
  int? chartType;
  String? idRelease;

  TopCountries(
      {this.title,
      this.subtitle,
      this.total,
      this.change,
      this.attributes,
      this.chartType,
      this.idRelease});

  TopCountries.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    total = json['total'];
    change = json['change'];
    if (json['attributes'] != null) {
      attributes = <AttributesTopCountries>[];
      json['attributes'].forEach((v) {
        attributes!.add(AttributesTopCountries.fromJson(v));
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
          attributes!.map((AttributesTopCountries v) => v.toJson()).toList();
    }
    data['chart_type'] = chartType;
    data['idRelease'] = idRelease;
    return data;
  }
}

class AttributesTopCountries {
  String? name;
  String? value;
  String? type;

  AttributesTopCountries({this.name, this.value, this.type});

  AttributesTopCountries.fromJson(Map<String, dynamic> json) {
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
