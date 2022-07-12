class DashboardGrowth {
  int? status;
  List<DataGrowth>? data;

  DashboardGrowth({this.status, this.data});

  DashboardGrowth.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataGrowth>[];
      json['data'].forEach((v) {
        data!.add(DataGrowth.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((DataGrowth v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataGrowth {
  String? dateNow;
  String? amountNow;
  String? dateLast;
  String? amountLast;
  double? change;
  int? hasData;

  DataGrowth(
      {this.dateNow,
      this.amountNow,
      this.dateLast,
      this.amountLast,
      this.change,
      this.hasData});

  DataGrowth.fromJson(Map<String, dynamic> json) {
    dateNow = json['date_now'];
    amountNow = json['amount_now'];
    dateLast = json['date_last'];
    amountLast = json['amount_last'];
    change = double.parse("${json['change']}");
    hasData = json['has_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_now'] = dateNow;
    data['amount_now'] = amountNow;
    data['date_last'] = dateLast;
    data['amount_last'] = amountLast;
    data['change'] = change;
    data['has_data'] = hasData;
    return data;
  }
}
