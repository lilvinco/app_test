import 'package:igroove_fan_box_one/model/assets_model.dart';

class NotificationModel {
  int? status;
  int? unseenNotificationCount;
  List<Notifications>? payload;

  NotificationModel({this.status, this.unseenNotificationCount, this.payload});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    unseenNotificationCount = json['unseenNotificationCount'];
    if (json['payload'] != null) {
      payload = <Notifications>[];
      json['payload'].forEach((v) {
        payload!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['unseenNotificationCount'] = unseenNotificationCount;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  int? appInstanceId;
  String? title;
  String? body;
  String? image;
  int? type;
  int? isArchived;
  int? entityId;
  Content? content;
  String? createdAt;
  String? updatedAt;
  DateTime? dateSeen;
  int? createdAtTimestamp;
  int? updatedAtTimestamp;

  Notifications(
      {this.id,
      this.appInstanceId,
      this.title,
      this.body,
      this.image,
      this.type,
      this.isArchived,
      this.entityId,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.dateSeen,
      this.createdAtTimestamp,
      this.updatedAtTimestamp});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appInstanceId = json['app_instance_id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    type = json['type'];
    isArchived = json['is_archived'];
    entityId = json['entity_id'];
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dateSeen =
        json['date_seen'] != null ? DateTime.parse(json['date_seen']) : null;
    createdAtTimestamp = json['created_at_timestamp'];
    updatedAtTimestamp = json['updated_at_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['app_instance_id'] = appInstanceId;
    data['title'] = title;
    data['body'] = body;
    data['image'] = image;
    data['type'] = type;
    data['is_archived'] = isArchived;
    data['entity_id'] = entityId;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['date_seen'] = dateSeen;
    data['created_at_timestamp'] = createdAtTimestamp;
    data['updated_at_timestamp'] = updatedAtTimestamp;
    return data;
  }
}

class Content {
  FanQuestion? fanQuestion;
  AssetModel? digitalFanBoxAsset;

  Content({this.fanQuestion, this.digitalFanBoxAsset});

  Content.fromJson(Map<String, dynamic> json) {
    fanQuestion = json['fanQuestion'] != null
        ? FanQuestion.fromJson(json['fanQuestion'])
        : null;
    digitalFanBoxAsset = json['digitalFanBoxAsset'] != null
        ? AssetModel.fromJson(json['digitalFanBoxAsset'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fanQuestion != null) {
      data['fanQuestion'] = fanQuestion!.toJson();
    }
    if (digitalFanBoxAsset != null) {
      data['digitalFanBoxAsset'] = digitalFanBoxAsset!.toJson();
    }
    return data;
  }
}

class FanQuestion {
  int? id;
  int? appInstanceId;
  int? userId;
  String? question;
  int? isArchived;
  int? voteCount;
  int? upvoteCount;
  int? downvoteCount;
  bool? authUserAdded;
  bool? authUserCanVote;
  bool? authUserUpVoted;
  bool? authUserDownVoted;
  bool? authUserReported;
  bool? authUserCanArchive;
  String? userName;
  String? userProfilePictureUrl;
  int? createdAtTimestamp;
  List<FanQuestion>? answers;
  bool? isArtist;

  FanQuestion(
      {this.id,
      this.appInstanceId,
      this.userId,
      this.question,
      this.isArchived,
      this.voteCount,
      this.upvoteCount,
      this.downvoteCount,
      this.authUserAdded,
      this.authUserCanVote,
      this.authUserUpVoted,
      this.authUserDownVoted,
      this.authUserReported,
      this.authUserCanArchive,
      this.userName,
      this.userProfilePictureUrl,
      this.createdAtTimestamp,
      this.answers,
      this.isArtist});

  FanQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appInstanceId = json['app_instance_id'];
    userId = json['user_id'];
    question = json['question'];
    isArchived = json['is_archived'];
    voteCount = json['vote_count'];
    upvoteCount = json['upvote_count'];
    downvoteCount = json['downvote_count'];
    authUserAdded = json['auth_user_added'];
    authUserCanVote = json['auth_user_can_vote'];
    authUserUpVoted = json['auth_user_up_voted'];
    authUserDownVoted = json['auth_user_down_voted'];
    authUserReported = json['auth_user_reported'];
    authUserCanArchive = json['auth_user_can_archive'];
    userName = json['user_name'];
    userProfilePictureUrl = json['user_profile_picture_url'];
    createdAtTimestamp = json['created_at_timestamp'];
    if (json['answers'] != null) {
      answers = <FanQuestion>[];
      json['answers'].forEach((v) {
        answers!.add(FanQuestion.fromJson(v));
      });
    }
    isArtist = json['is_artist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['app_instance_id'] = appInstanceId;
    data['user_id'] = userId;
    data['question'] = question;
    data['is_archived'] = isArchived;
    data['vote_count'] = voteCount;
    data['upvote_count'] = upvoteCount;
    data['downvote_count'] = downvoteCount;
    data['auth_user_added'] = authUserAdded;
    data['auth_user_can_vote'] = authUserCanVote;
    data['auth_user_up_voted'] = authUserUpVoted;
    data['auth_user_down_voted'] = authUserDownVoted;
    data['auth_user_reported'] = authUserReported;
    data['auth_user_can_archive'] = authUserCanArchive;
    data['user_name'] = userName;
    data['user_profile_picture_url'] = userProfilePictureUrl;
    data['created_at_timestamp'] = createdAtTimestamp;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['is_artist'] = isArtist;
    return data;
  }
}
