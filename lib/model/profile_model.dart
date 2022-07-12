import 'dart:io';

class ProfileResponse {
  int? status;
  Payload? payload;

  ProfileResponse({this.status, this.payload});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? profilePicture;
  String? city;
  String? userName;
  String? email;
  String? userProfilePictureUrl;
  File? profilePictureFile;
  String? password;
  String? passwordConfirmation;
  String? oldPassword;
  DateTime? birthday;
  String? telephone;
  bool? isArtist;
  int? fanPoints;

  Payload(
      {this.id,
      this.name,
      this.profilePicture,
      this.city,
      this.userName,
      this.email,
      this.userProfilePictureUrl,
      this.profilePictureFile,
      this.password,
      this.passwordConfirmation,
      this.oldPassword,
      this.birthday,
      this.telephone,
      this.isArtist,
      this.fanPoints});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fanPoints = json['fan_points'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    city = json['city'];
    userName = json['user_name'];
    email = json['email'];
    userProfilePictureUrl = json['user_profile_picture_url'];
    telephone = json['phone_number'];
    birthday = json['birthday'] != null && json['birthday'] != '0'
        ? DateTime.parse(json['birthday'])
        : null;
    isArtist = json['is_artist'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['fan_points'] = fanPoints;
    data['profile_picture'] = profilePicture;
    data['city'] = city;
    data['user_name'] = userName;
    data['email'] = email;
    data['user_profile_picture_url'] = userProfilePictureUrl;
    data['profile_picture'] = profilePictureFile;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['old_password'] = oldPassword;
    data['phone_number'] = telephone;
    data['birthday'] = birthday != null
        ? "${birthday!.year}-${birthday!.month}-${birthday!.day}"
        : birthday;
    data['is_artist'] = isArtist! ? 1 : 0;
    return data;
  }
}
