class SaveContributorModel {
  String? message;
  int? status;
  bool? complete;
  String? value;

  SaveContributorModel({this.message, this.status, this.complete, this.value});

  SaveContributorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    complete = json['complete'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['complete'] = complete;
    data['value'] = value;
    return data;
  }
}
