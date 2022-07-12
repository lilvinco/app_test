class ReleaseProcessOpenModel {
  int? status;
  int? releaseProcessOpen;

  ReleaseProcessOpenModel({this.status, this.releaseProcessOpen});

  ReleaseProcessOpenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    releaseProcessOpen = json['releaseProcessOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['releaseProcessOpen'] = releaseProcessOpen;
    return data;
  }
}
