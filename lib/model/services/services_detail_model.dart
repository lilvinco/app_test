class ServiceDetailModel {
  int? status;
  Payload? payload;

  ServiceDetailModel({this.status, this.payload});

  ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  Service? service;

  Payload({this.service});

  Payload.fromJson(Map<String, dynamic> json) {
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class Service {
  String? id;
  String? title;
  String? picture;
  String? appPicture;
  String? quickPicture;
  String? description;
  String? moreTitle;
  String? moreDescription;

  Service(
      {this.id,
      this.title,
      this.picture,
      this.appPicture,
      this.quickPicture,
      this.description,
      this.moreTitle,
      this.moreDescription});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    picture = json['picture'];
    appPicture = json['app_picture'];
    quickPicture = json['quick_picture'];
    description = json['description'];
    moreTitle = json['more_title'];
    moreDescription = json['more_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['picture'] = picture;
    data['app_picture'] = appPicture;
    data['quick_picture'] = quickPicture;
    data['description'] = description;
    data['more_title'] = moreTitle;
    data['more_description'] = moreDescription;
    return data;
  }
}
