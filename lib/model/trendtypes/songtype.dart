class SongFilter {
  String? id;
  String? trackTitle;
  String? trackVersion;
  List<String>? trackArtist;
  List<dynamic>? trackFeaturing;
  String? trackNumber;
  String? albumTitle;
  String? albumVersion;
  String? selected;
  String? albumFullTitle;
  String? trackFullArtist;
  String? trackFullTitle;

  SongFilter(
      {this.id,
      this.trackTitle,
      this.trackVersion,
      this.trackArtist,
      this.trackFeaturing,
      this.trackNumber,
      this.albumTitle,
      this.albumVersion,
      this.selected,
      this.albumFullTitle,
      this.trackFullArtist,
      this.trackFullTitle});
      

  SongFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackTitle = json['trackTitle'];
    trackVersion = json['trackVersion'];
    trackArtist = json['trackArtist']?.cast<String>();
    if (json['trackFeaturing'] != null) {
      trackFeaturing = <dynamic>[];
    }
    trackNumber = json['trackNumber'];
    albumTitle = json['albumTitle'];
    albumVersion = json['albumVersion'];
    selected = json['selected'];
    albumFullTitle = json['albumFullTitle'];
    trackFullArtist = json['trackFullArtist'];
    trackFullTitle = json['trackFullTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trackTitle'] = trackTitle;
    data['trackVersion'] = trackVersion;
    data['trackArtist'] = trackArtist;
    if (trackFeaturing != null) {
      data['trackFeaturing'] =
          trackFeaturing!.map((v) => v.toJson()).toList();
    }
    data['trackNumber'] = trackNumber;
    data['albumTitle'] = albumTitle;
    data['albumVersion'] = albumVersion;
    data['selected'] = selected;
    data['albumFullTitle'] = albumFullTitle;
    data['trackFullArtist'] = trackFullArtist;
    data['trackFullTitle'] = trackFullTitle;
    return data;
  }
}
