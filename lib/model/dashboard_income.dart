class DashboardIncome {
  int? status;
  List<IncomeData>? data;

  DashboardIncome({this.status, this.data});

  DashboardIncome.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <IncomeData>[];
      json['data'].forEach((v) {
        data!.add(IncomeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((IncomeData v) => v.toJson()).toList();
    }
    return data;
  }
}

class IncomeData {
  String? grand;
  String? grandLast;
  String? lastPercent;
  String? diff;
  String? dateStart;
  String? dateEnd;

  IncomeData(
      {this.grand,
      this.grandLast,
      this.lastPercent,
      this.diff,
      this.dateStart,
      this.dateEnd});

  IncomeData.fromJson(Map<String, dynamic> json) {
    grand = json['grand'];
    grandLast = json['grand_last'];
    lastPercent = json['last_percent'];
    diff = json['diff'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grand'] = grand;
    data['grand_last'] = grandLast;
    data['last_percent'] = lastPercent;
    data['diff'] = diff;
    data['date_start'] = dateStart;
    data['date_end'] = dateEnd;
    return data;
  }
}
