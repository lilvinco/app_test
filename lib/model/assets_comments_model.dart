class AssetsCommentResponse {
  int? status;
  int? count;
  int? totalComments;
  Payload? payload;

  AssetsCommentResponse({
    this.status,
    this.payload,
    this.count,
    this.totalComments,
  });

  AssetsCommentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    totalComments = json['display_count'];
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
  List<Comments>? comments;

  Payload({this.comments});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  int? userId;
  int? digitalFanBoxAssetId;
  String? comment;
  String? userName;
  String? userProfilePictureUrl;
  int? createdAtTimestamp;
  bool? authUserLiked;
  bool? authUserDisliked;
  List<Comments>? childComments;
  Statistics? statistics;
  bool? isArtist;
  bool? authuserCanArchive;

  Comments({
    this.id,
    this.userId,
    this.digitalFanBoxAssetId,
    this.comment,
    this.userName,
    this.authUserDisliked,
    this.authUserLiked,
    this.statistics,
    this.userProfilePictureUrl,
    this.createdAtTimestamp,
    this.childComments,
    this.isArtist,
    this.authuserCanArchive,
  });

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    digitalFanBoxAssetId = json['digital_fan_box_asset_id'];
    comment = json['comment'];
    authUserLiked = json['auth_user_liked'];
    authUserDisliked = json['auth_user_disliked'];
    userName = json['user_name'];
    createdAtTimestamp = json['created_at_timestamp'];
    userProfilePictureUrl = json['user_profile_picture_url'];
    isArtist = json['is_artist'];
    authuserCanArchive = json['auth_user_can_archive'];
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
    if (json['child_comments'] != null) {
      childComments = <Comments>[];
      json['child_comments'].forEach((v) {
        childComments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['digital_fan_box_asset_id'] = digitalFanBoxAssetId;
    data['comment'] = comment;
    data['user_name'] = userName;
    data['user_profile_picture_url'] = userProfilePictureUrl;
    data['created_at_timestamp'] = createdAtTimestamp;
    data['auth_user_liked'] = authUserLiked;
    data['auth_user_disliked'] = authUserDisliked;
    data['auth_user_can_archive'] = authuserCanArchive;
    data['is_artist'] = isArtist;
    if (childComments != null) {
      data['child_comments'] = childComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statistics {
  int? likes;
  int? dislikes;
  String? likesFormatted;
  String? dislikesFormatted;

  Statistics(
      {this.likes, this.dislikes, this.likesFormatted, this.dislikesFormatted});

  Statistics.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    dislikes = json['dislikes'];
    likesFormatted = json['likes_formatted'];
    dislikesFormatted = json['dislikes_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likes'] = likes;
    data['dislikes'] = dislikes;
    data['likes_formatted'] = likesFormatted;
    data['dislikes_formatted'] = dislikesFormatted;
    return data;
  }
}
