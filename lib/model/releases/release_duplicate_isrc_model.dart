class DuplicateIsrcModel {
  int? status;
  String? message;

  DuplicateIsrcModel({this.status, this.message});

  DuplicateIsrcModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
