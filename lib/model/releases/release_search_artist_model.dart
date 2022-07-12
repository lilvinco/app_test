class SearchArtistModel {
  int? status;
  List<Payload>? payload;

  SearchArtistModel({this.status, this.payload});

  SearchArtistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (payload != null) {
      data['payload'] = payload!.map((Payload v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? name;
  String? label;
  String? value;
  String? picture;
  String? genre;
  String? url;

  Payload(
      {this.id,
      this.name,
      this.label,
      this.value,
      this.picture,
      this.genre,
      this.url});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    label = json['label'];
    value = json['value'];
    picture = json['picture'];
    genre = json['genre'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['label'] = label;
    data['value'] = value;
    data['picture'] = picture;
    data['genre'] = genre;
    data['url'] = url;
    return data;
  }
}
