class TrendsInfo {
  Totals? totals;
  List<ListItem>? listitems;
  List<ChartData>? chartitems;
  String? currency;
  bool? hasTrends;
  TrendsInfo({this.totals, this.listitems, this.currency, this.chartitems});

  TrendsInfo.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      listitems = <ListItem>[];
      json['list'].forEach((v) {
        listitems!.add(ListItem.fromJson(v));
      });
    }

    totals = json['total'] != null ? Totals.fromJson(json['total']) : null;

    currency = json['currency'];
    hasTrends = json['hasTrends'] ?? false;

    if (json['chartData'] != null) {
      chartitems = <ChartData>[];
      json['chartData'].forEach((v) {
        chartitems!.add(ChartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }

    if (listitems != null) {
      data['total'] = listitems!.map((ListItem v) => v.toJson()).toList();
    }

    data['currency'] = currency;
    data['hasTrends'] = hasTrends;

    return data;
  }
}

class Totals {
  String? grand;
  String? grandLast;
  String? lastPercent;
  String? diff;

  Totals({this.grand, this.grandLast, this.lastPercent, this.diff});

  Totals.fromJson(Map<String, dynamic> json) {
    grand = json['grand'].toString();
    grandLast = json['grand_last'].toString();
    lastPercent = json['last_percent'].toString();
    diff = json['diff'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grand'] = grand;
    data['grand_last'] = grandLast;
    data['last_percent'] = lastPercent;
    data['diff'] = diff;
    return data;
  }
}

class ListItem {
  String? cover;
  String? title;
  String? subtitle;
  String? total;
  String? royalty;
  String? change;
  String? countryCode;
  List<Attributes>? attributes;
  String? chartType;

  ListItem(
      {this.cover,
      this.title,
      this.subtitle,
      this.total,
      this.royalty,
      this.change,
      this.countryCode,
      this.attributes,
      this.chartType});

  ListItem.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    title = json['title'];
    subtitle = json['subtitle'];
    total = json['total'].toString();
    royalty = json['royalty'].toString();
    change = json['change'].toString();
    countryCode = json['countryCode'].toString();
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    // chart = json['chart'].cast<int>();
    chartType = json['chart_type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cover'] = cover;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['total'] = total;
    data['royalty'] = royalty;
    data['change'] = change;
    data['countryCode'] = countryCode;
    if (attributes != null) {
      data['attributes'] =
          attributes!.map((Attributes v) => v.toJson()).toList();
    }
    data['chartType'] = chartType;
    return data;
  }
}

class ChartData {
  String? date;
  double? value;

  ChartData({this.date, this.value});

  ChartData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    value =
        json['value'] is int ? double.parse("${json['value']}") : json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['value'] = value;
    return data;
  }
}

class Attributes {
  String? name;
  String? value;
  String? type;
  String? percentage;

  Attributes({this.name, this.value, this.type, this.percentage});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    value = json['value'].toString();
    type = json['type'].toString();
    percentage = json['percent'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['type'] = type;
    data['percent'] = percentage;
    return data;
  }
}
