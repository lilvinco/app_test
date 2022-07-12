class KontoDetails {
  int? status;
  DetailsYears? years;
  List<DetailsReleases>? releases;
  List<DetailsStores>? stores;
  Totals? totals;

  KontoDetails(
      {this.status, this.years, this.releases, this.stores, this.totals});

  KontoDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    years = json['years'] != null ? DetailsYears.fromJson(json['years']) : null;
    if (json['releases'] != null) {
      releases = <DetailsReleases>[];
      json['releases'].forEach((v) {
        releases!.add(DetailsReleases.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <DetailsStores>[];
      json['stores'].forEach((v) {
        stores!.add(DetailsStores.fromJson(v));
      });
    }
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (years != null) {
      data['years'] = years!.toJson();
    }
    if (releases != null) {
      data['releases'] =
          releases!.map((DetailsReleases v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((DetailsStores v) => v.toJson()).toList();
    }
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    return data;
  }
}

class DetailsYears {
  List<String>? l2017;
  List<String>? l2018;
  List<String>? l2019;

  DetailsYears({this.l2017, this.l2018, this.l2019});

  DetailsYears.fromJson(Map<String, dynamic> json) {
    l2017 = json['2017'].cast<String>();
    l2018 = json['2018'].cast<String>();
    l2019 = json['2019'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['2017'] = l2017;
    data['2018'] = l2018;
    data['2019'] = l2019;
    return data;
  }
}

class DetailsReleases {
  String? title;
  String? subtitle;
  String? total;
  String? change;

  DetailsReleases({this.title, this.subtitle, this.total});

  DetailsReleases.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    total = json['total'];
    change = json['change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['total'] = total;
    data['change'] = change;

    return data;
  }
}

class Totals {
  String? title;
  String? subtitle;
  String? total;

  Totals({this.title, this.subtitle, this.total});

  Totals.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['total'] = total;
    return data;
  }
}

class DetailsStores {
  String? title;
  String? subtitle;
  String? total;
  String? change;

  DetailsStores({this.title, this.subtitle, this.total});

  DetailsStores.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    total = json['total'];
    change = json['change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['total'] = total;
    data['change'] = change;
    return data;
  }
}
