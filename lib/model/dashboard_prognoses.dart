class DashboardPrognoses {
  int? status;
  List<DataPrognoses>? data;

  DashboardPrognoses({this.status, this.data});

  DashboardPrognoses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataPrognoses>[];
      json['data'].forEach((v) {
        data!.add(DataPrognoses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((DataPrognoses v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataPrognoses {
  String? timePeriod;
  String? amount;
  int? percentage;

  DataPrognoses({this.timePeriod, this.amount, this.percentage});

  DataPrognoses.fromJson(Map<String, dynamic> json) {
    timePeriod = json['time_period'];
    amount = json['amount'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_period'] = timePeriod;
    data['amount'] = amount;
    data['percentage'] = percentage;
    return data;
  }
}
