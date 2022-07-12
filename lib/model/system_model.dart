class System {
  String? version;
  AppInstance? appInstance;

  System({this.version, this.appInstance});

  System.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appInstance = json['app_instance'] != null
        ? AppInstance.fromJson(json['app_instance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    if (appInstance != null) {
      data['app_instance'] = appInstance!.toJson();
    }
    return data;
  }
}

class AppInstance {
  int? id;
  String? name;
  String? token;
  String? appStoreLink;
  String? googlePlayLink;
  String? fcmServerKey;
  String? iosAppId;
  String? androidAppId;
  String? iosAppVersion;
  String? androidAppVersion;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AppInstance(
      {this.id,
      this.name,
      this.token,
      this.appStoreLink,
      this.googlePlayLink,
      this.fcmServerKey,
      this.iosAppId,
      this.androidAppId,
      this.iosAppVersion,
      this.androidAppVersion,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  AppInstance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    token = json['token'];
    appStoreLink = json['app_store_link'];
    googlePlayLink = json['google_play_link'];
    fcmServerKey = json['fcm_server_key'];
    iosAppId = json['ios_app_id'];
    androidAppId = json['android_app_id'];
    iosAppVersion = json['ios_app_version'];
    androidAppVersion = json['android_app_version'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['token'] = token;
    data['app_store_link'] = appStoreLink;
    data['google_play_link'] = googlePlayLink;
    data['fcm_server_key'] = fcmServerKey;
    data['ios_app_id'] = iosAppId;
    data['android_app_id'] = androidAppId;
    data['ios_app_version'] = iosAppVersion;
    data['android_app_version'] = androidAppVersion;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
