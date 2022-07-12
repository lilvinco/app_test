class FanRankingModel {
  int? status;
  List<RankingModel>? rankingList;

  FanRankingModel({this.status, this.rankingList});

  FanRankingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payload'] != null) {
      rankingList = <RankingModel>[];
      json['payload'].forEach((v) {
        rankingList!.add(RankingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (rankingList != null) {
      data['payload'] = rankingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RankingModel {
  int? id;
  String? name;
  String? profilePicture;
  String? city;
  String? userName;
  String? email;
  String? birthday;
  String? phoneNumber;
  String? userProfilePictureUrl;
  int? fanPoints;

  RankingModel(
      {this.id,
      this.name,
      this.profilePicture,
      this.city,
      this.userName,
      this.email,
      this.birthday,
      this.phoneNumber,
      this.userProfilePictureUrl,
      this.fanPoints});

  RankingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePicture = json['profile_picture'];
    city = json['city'];
    userName = json['user_name'];
    email = json['email'];
    birthday = json['birthday'];
    phoneNumber = json['phone_number'];
    userProfilePictureUrl = json['user_profile_picture_url'];
    fanPoints = json['fan_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_picture'] = profilePicture;
    data['city'] = city;
    data['user_name'] = userName;
    data['email'] = email;
    data['birthday'] = birthday;
    data['phone_number'] = phoneNumber;
    data['user_profile_picture_url'] = userProfilePictureUrl;
    data['fan_points'] = fanPoints;
    return data;
  }
}
