class ReleaseFilter {
  String? id;
  String? title;
  String? titleVersion;
  List<String>? artist;
  List<dynamic>? featuring;
  String? royalties;
  String? selected;
  String? fullArtist;
  String? fullTitle;

  ReleaseFilter(
      {this.id,
      this.title,
      this.titleVersion,
      this.artist,
      this.featuring,
      this.royalties,
      this.selected,
      this.fullArtist,
      this.fullTitle});

  ReleaseFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleVersion = json['titleVersion'];
    artist = json['artist']?.cast<String>();
    if (json['featuring'] != null) {
      featuring = <dynamic>[];
      json['featuring'].forEach((v) {});
    }
    royalties = json['royalties'];
    selected = json['selected'];
    fullArtist = json['fullArtist'];
    fullTitle = json['fullTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['titleVersion'] = titleVersion;
    data['artist'] = artist;
    if (featuring != null) {
      data['featuring'] = featuring!.map((v) => v.toJson()).toList();
    }
    data['royalties'] = royalties;
    data['selected'] = selected;
    data['fullArtist'] = fullArtist;
    data['fullTitle'] = fullTitle;
    return data;
  }
}
