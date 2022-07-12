class TrendsShareDataModel {
  int? status;
  Share? share;

  TrendsShareDataModel({this.status, this.share});

  TrendsShareDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    share = json['share'] != null ? Share.fromJson(json['share']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (share != null) {
      data['share'] = share!.toJson();
    }
    return data;
  }
}

class Share {
  bool? enabled;
  String? insightLink;
  String? quickInsightLink;

  Share({this.enabled, this.insightLink, this.quickInsightLink});

  Share.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'] != null ? int.parse(json['enabled']) == 1 : false;
    insightLink = json['insight_link'] ?? "";
    quickInsightLink = json['quick_insight_link'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled! ? 1:0;
    data['insight_link'] = insightLink;
    data['quick_insight_link'] = quickInsightLink;
    return data;
  }
}