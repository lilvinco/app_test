class ReleaseListGenreModel {
  int? status;
  Payload? payload;

  ReleaseListGenreModel({this.status, this.payload});

  ReleaseListGenreModel.fromJson(Map<String, dynamic> json) {
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
  List<ReleaseGenres>? genres;

  Payload({this.genres});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <ReleaseGenres>[];
      json['genres'].forEach((v) {
        genres!.add(ReleaseGenres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (genres != null) {
      data['genres'] = genres!.map((ReleaseGenres v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReleaseGenres {
  String? id;
  String? name;
  String? itunesPrimary;
  String? itunesSecondary;
  String? classical;
  String? isAudioBook;

  ReleaseGenres(
      {this.id,
      this.name,
      this.itunesPrimary,
      this.itunesSecondary,
      this.classical,
      this.isAudioBook});

  ReleaseGenres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    itunesPrimary = json['itunes_primary'];
    itunesSecondary = json['itunes_secondary'];
    classical = json['classical'];
    isAudioBook = json['is_audio_book'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['itunes_primary'] = itunesPrimary;
    data['itunes_secondary'] = itunesSecondary;
    data['classical'] = classical;
    data['is_audio_book'] = isAudioBook;
    return data;
  }
}
