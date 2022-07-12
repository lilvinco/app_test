class DashboardNextPayout {
  int? status;
  List<DataNextPayout>? data;

  DashboardNextPayout({this.status, this.data});

  DashboardNextPayout.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataNextPayout>[];
      json['data'].forEach((v) {
        data!.add(DataNextPayout.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((DataNextPayout v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataNextPayout {
  String? date;
  String? amount;
  double? percentage;
  double? generalDirection;
  List<Components>? components;

  DataNextPayout(
      {this.date,
      this.amount,
      this.percentage,
      this.generalDirection,
      this.components});

  DataNextPayout.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    percentage = double.parse("${json['percentage']}");
    generalDirection = double.parse("${json['general_direction']}");
    if (json['components'] != null) {
      components = <Components>[];
      json['components'].forEach((v) {
        components!.add(Components.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['amount'] = amount;
    data['percentage'] = percentage;
    data['general_direction'] = generalDirection;
    if (components != null) {
      data['components'] =
          components!.map((Components v) => v.toJson()).toList();
    }
    return data;
  }
}

class Components {
  String? name;
  String? method;
  double? revenues;
  double? completeness;
  double? share;
  double? lastReportRev;
  double? change;

  Components(
      {this.name,
      this.method,
      this.revenues,
      this.completeness,
      this.share,
      this.lastReportRev,
      this.change});

  Components.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    method = json['method'];
    revenues = double.parse("${json['revenues']}");
    completeness = double.parse("${json['completeness']}");
    share = double.parse("${json['share']}");
    lastReportRev = double.parse("${json['last_report_rev']}");
    change = double.parse("${json['change']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['method'] = method;
    data['revenues'] = revenues;
    data['completeness'] = completeness;
    data['share'] = share;
    data['last_report_rev'] = lastReportRev;
    data['change'] = change;
    return data;
  }
}
