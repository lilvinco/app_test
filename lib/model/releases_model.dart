import 'package:igroove_fan_box_one/model/assets_model.dart';

class ReleaseModel {
  int? status;
  List<Releases>? releases;

  ReleaseModel({this.status, this.releases});

  ReleaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['releases'] != null) {
      releases = <Releases>[];
      json['releases'].forEach((v) {
        releases!.add(Releases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (releases != null) {
      data['releases'] = releases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Releases {
  int? id;
  int? digitalFanBoxId;
  String? artist;
  String? title;
  String? createdAt;
  String? updatedAt;
  String? coverUrl;
  String? mediaType;
  List<AssetModel>? tracks;

  Releases(
      {this.id,
      this.digitalFanBoxId,
      this.artist,
      this.title,
      this.coverUrl,
      this.createdAt,
      this.updatedAt,
      this.mediaType,
      this.tracks});

  Releases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    digitalFanBoxId = json['digital_fan_box_id'];
    artist = json['artist'];
    title = json['title'];
    coverUrl = json['cover_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mediaType = json['media_type'];
    if (json['tracks'] != null) {
      tracks = <AssetModel>[];
      json['tracks'].forEach((v) {
        tracks!.add(AssetModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['digital_fan_box_id'] = digitalFanBoxId;
    data['artist'] = artist;
    data['title'] = title;
    data['cover_url'] = coverUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['media_type'] = mediaType;
    if (tracks != null) {
      data['tracks'] = tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
