class TrendsChart {
  int? status;
  Data? data;

  TrendsChart({this.status, this.data});

  TrendsChart.fromJson(Map<String, dynamic> json) {
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
  List<String>? labels;
  Series? series;

  Data({this.labels, this.series});

  Data.fromJson(Map<String, dynamic> json) {
    labels = json['labels'].cast<String>();
    series =
        json['series'] != null ? Series.fromJson(json['series']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['labels'] = labels;
    if (series != null) {
      data['series'] = series!.toJson();
    }
    return data;
  }
}

class Series {
  String? name;
  List<double>? data = [];

  Series({this.name, this.data});

  Series.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    json['data']?.forEach((item){
      data!.add(double.parse(item.toString()));
    });
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['data'] = this.data;
    return data;
  }
}
