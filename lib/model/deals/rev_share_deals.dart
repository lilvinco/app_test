class RevShareDeals {
  List<Deals>? deals;

  RevShareDeals({this.deals});

  RevShareDeals.fromJson(Map<String, dynamic> json) {
    if (json['deals'] != null) {
      deals = <Deals>[];
      json['deals'].forEach((v) {
        deals!.add(Deals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deals != null) {
      data['deals'] = deals!.map((Deals v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deals {
  String? id;
  String? idRelease;
  String? coverUrl;
  String? title;
  String? artist;
  String? status;
  String? active;
  String? idReleaseDealPartner;

  Deals(
      {this.id,
      this.idRelease,
      this.coverUrl,
      this.title,
      this.idReleaseDealPartner,
      this.artist,
      this.active,
      this.status});

  Deals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRelease = json['idRelease'];
    coverUrl = json['cover_url'];
    idReleaseDealPartner = json['idReleaseDealPartner'];
    title = json['title'];
    artist = json['artist'];
    active = json['active'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idRelease'] = idRelease;
    data['cover_url'] = coverUrl;
    data['title'] = title;
    data['idReleaseDealPartner'] = idReleaseDealPartner;
    data['artist'] = artist;
    data['active'] = active;
    data['status'] = status;
    return data;
  }
}
