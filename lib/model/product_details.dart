class ProductDetails {
  String? id;
  String? eanCode;
  String? coverUrlThumb;
  String? artist;
  String? title;
  String? dateRelease;
  int? isLabelcopyPdfGenerated;
  List<Tracklist>? tracklist;
  String? dealName;
  bool? isEditable;
  String? editableError;
  bool? isLocked;
  bool? isUnlockable;

  ProductDetails(
      {this.id,
      this.isLabelcopyPdfGenerated,
      this.eanCode,
      this.coverUrlThumb,
      this.artist,
      this.title,
      this.dateRelease,
      this.tracklist,
      this.dealName,
      this.isEditable,
      this.isLocked,
      this.isUnlockable,
      this.editableError});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eanCode = json['eanCode'];
    isLabelcopyPdfGenerated = json['is_labelcopy_pdf_generated'];
    coverUrlThumb = json['cover_url_thumb'];
    artist = json['artist'];
    title = json['title'];
    dateRelease = json['date_release'];
    if (json['tracklist'] != null) {
      tracklist = <Tracklist>[];
      json['tracklist'].forEach((v) {
        tracklist!.add(Tracklist.fromJson(v));
      });
    }
    dealName = json['deal_name'];
    isEditable = json['is_editable'];
    editableError = json['editable_error'];
    isLocked = json['is_locked'];
    isUnlockable = json['is_unlockable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eanCode'] = eanCode;
    data['cover_url_thumb'] = coverUrlThumb;
    data['is_labelcopy_pdf_generated'] = isLabelcopyPdfGenerated;
    data['artist'] = artist;
    data['title'] = title;
    data['date_release'] = dateRelease;
    if (tracklist != null) {
      data['tracklist'] = tracklist!.map((Tracklist v) => v.toJson()).toList();
    }
    data['is_editable'] = isEditable;
    data['editable_error'] = editableError;
    data['is_locked'] = isLocked;
    data['is_unlockable'] = isUnlockable;
    return data;
  }
}

class Tracklist {
  String? idTrack;
  String? isrc;
  String? trackNumber;
  String? artist;
  String? title;
  String? duration;
  String? audioSnippetUrl;
  String? filename;
  String? url;
  String? description;
  int? order;

  Tracklist(
      {this.idTrack,
      this.isrc,
      this.trackNumber,
      this.artist,
      this.title,
      this.duration,
      this.filename,
      this.url,
      this.order,
      this.description,
      this.audioSnippetUrl});

  Tracklist.fromJson(Map<String, dynamic> json) {
    idTrack = json['idTrack'];
    isrc = json['isrc'];
    trackNumber = json['trackNumber'];
    artist = json['artist'];
    title = json['title'];
    filename = json['filename'];
    url = json['url'];
    order = json['order'];
    duration = json['duration'];
    description = json['description'];
    audioSnippetUrl = json['audio_snippet_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTrack'] = idTrack;
    data['isrc'] = isrc;
    data['trackNumber'] = trackNumber;
    data['artist'] = artist;
    data['title'] = title;
    data['filename'] = filename;
    data['url'] = url;
    data['order'] = order;
    data['duration'] = duration;
    data['description'] = description;
    data['audio_snippet_url'] = audioSnippetUrl;
    return data;
  }
}
