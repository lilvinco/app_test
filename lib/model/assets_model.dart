class AssetsResponse {
  int? status;
  List<AssetModel>? assetList;

  AssetsResponse({this.status, this.assetList});

  AssetsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payload'] != null) {
      assetList = <AssetModel>[];
      json['payload'].forEach((v) {
        assetList!.add(AssetModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (assetList != null) {
      data['payload'] = assetList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssetModel {
  String? id;
  int? digitalFanBoxId;
  int? type;
  int? isNewsFeedItem;
  String? artist;
  int? order;
  int? width;
  int? height;
  String? title;
  String? shortTitle;
  String? filename;
  String? length;
  String? description;
  String? shortDescription;
  String? downloadUrl;
  String? streamingUrl;
  Uploader? uploader;
  bool? authUserCanLike;
  bool? authUserCanDislike;
  bool? authUserLiked;
  bool? authUserDisliked;
  String? thumbnailFilename;
  String? thumbnailUrl;
  String? typeString;
  Statistics? statistics;
  int? createdAtTimestamp;
  int? updatedAtTimestamp;
  int? showdateTimestamp;
  bool? datePinned;

  AssetModel({
    this.id,
    this.digitalFanBoxId,
    this.type,
    this.isNewsFeedItem,
    this.artist,
    this.order,
    this.streamingUrl,
    this.width,
    this.height,
    this.title,
    this.shortTitle,
    this.datePinned,
    this.filename,
    this.length,
    this.authUserCanLike,
    this.authUserCanDislike,
    this.authUserLiked,
    this.authUserDisliked,
    this.description,
    this.shortDescription,
    this.downloadUrl,
    this.thumbnailFilename,
    this.thumbnailUrl,
    this.typeString,
    this.statistics,
    this.createdAtTimestamp,
    this.updatedAtTimestamp,
    this.showdateTimestamp,
  });

  AssetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    digitalFanBoxId = json['digital_fan_box_id'];
    type = json['type'];
    isNewsFeedItem = json['is_news_feed_item'];
    artist = json['artist'];
    order = json['order'];
    width = json['width'];
    height = json['height'];
    streamingUrl = json['streaming_url'];
    title = json['title'];
    shortTitle = json['short_title'];
    filename = json['filename'].toString().replaceAll(' ', '');
    length = json['length'];
    description = json['description'];
    shortDescription = json['short_description'];
    downloadUrl = json['download_url'];
    thumbnailFilename =
        json['thumbnail_filename'].toString().replaceAll(' ', '');
    thumbnailUrl = json['thumbnail_url'];
    typeString = json['type_string'];
    createdAtTimestamp = json['created_at_timestamp'];
    updatedAtTimestamp = json['updated_at_timestamp'];
    datePinned = json['date_pinned'] != null ? true : false;
    showdateTimestamp = json['show_date_timestamp'];
    uploader =
        json['uploader'] != null ? Uploader.fromJson(json['uploader']) : null;
    authUserCanLike = json['auth_user_can_like'];
    authUserCanDislike = json['auth_user_can_dislike'];
    authUserLiked = json['auth_user_liked'];
    authUserDisliked = json['auth_user_disliked'];
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['digital_fan_box_id'] = digitalFanBoxId;
    data['type'] = type;
    data['is_news_feed_item'] = isNewsFeedItem;
    data['artist'] = artist;
    data['order'] = order;
    data['title'] = title;
    data['width'] = width;
    data['height'] = height;
    data['short_title'] = shortTitle;
    data['filename'] = filename;
    data['length'] = length;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['streaming_url'] = streamingUrl;
    data['authUserCanLike'] = authUserCanLike;
    data['download_url'] = downloadUrl;
    data['thumbnail_filename'] = thumbnailFilename;
    data['thumbnailUrl'] = thumbnailUrl;
    data['created_at_timestamp'] = createdAtTimestamp;
    data['updated_at_timestamp'] = updatedAtTimestamp;
    data['show_date_timestamp'] = showdateTimestamp;
    data['type_string'] = typeString;
    data['auth_user_can_like'] = authUserCanLike;
    data['auth_user_can_dislike'] = authUserCanDislike;
    data['auth_user_liked'] = authUserLiked;
    data['auth_user_disliked'] = authUserDisliked;
    if (uploader != null) {
      data['uploader'] = uploader!.toJson();
    }
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    return data;
  }
}

class Uploader {
  String? name;
  String? userName;
  String? profilePictureUrl;

  Uploader({this.name, this.userName, this.profilePictureUrl});

  Uploader.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['user_name'];
    profilePictureUrl = json['profile_picture_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['user_name'] = userName;
    data['profile_picture_url'] = profilePictureUrl;
    return data;
  }
}

class Statistics {
  int? views;
  int? comments;
  int? likes;
  int? dislikes;
  String? viewsFormatted;
  String? commentsFormatted;
  String? likesFormatted;
  String? dislikesFormatted;

  Statistics(
      {this.views,
      this.comments,
      this.likes,
      this.dislikes,
      this.viewsFormatted,
      this.commentsFormatted,
      this.likesFormatted,
      this.dislikesFormatted});

  Statistics.fromJson(Map<String, dynamic> json) {
    views = json['views'];
    comments = json['comments'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    viewsFormatted = json['views_formatted'];
    commentsFormatted = json['comments_formatted'];
    likesFormatted = json['likes_formatted'];
    dislikesFormatted = json['dislikes_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['views'] = views;
    data['comments'] = comments;
    data['likes'] = likes;
    data['dislikes'] = dislikes;
    data['views_formatted'] = viewsFormatted;
    data['comments_formatted'] = commentsFormatted;
    data['likes_formatted'] = likesFormatted;
    data['dislikes_formatted'] = dislikesFormatted;
    return data;
  }
}
