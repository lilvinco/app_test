class DealTracks {
  Details? details;
  List<Roles>? roles;
  List<Track>? tracks;

  DealTracks({
    this.details,
    this.roles,
    this.tracks,
  });

  DealTracks.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    if (json['tracks'] != null) {
      tracks = <Track>[];
      json['tracks'].forEach((v) {
        tracks!.add(Track.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.toJson();
    }
    if (roles != null) {
      data['roles'] = roles!.map((Roles v) => v.toJson()).toList();
    }
    if (tracks != null) {
      data['tracks'] = tracks!.map((Track v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? id;
  String? idRelease;
  String? coverUrl;
  String? title;
  String? artist;
  String? status;
  String? active;
  String? dateDecline;
  String? dateAccepted;
  String? dateLastInvite;
  String? declineReason;
  String? dateStart;
  String? dateCreated;
  String? dateModified;

  Details({
    this.id,
    this.idRelease,
    this.coverUrl,
    this.title,
    this.artist,
    this.status,
    this.active,
    this.dateDecline,
    this.dateAccepted,
    this.declineReason,
    this.dateLastInvite,
    this.dateStart,
    this.dateCreated,
    this.dateModified,
  });

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRelease = json['idRelease'];
    coverUrl = json['cover_url'];
    title = json['title'] != null
        ? json['title'].toString().split("").join(String.fromCharCode(8203))
        : json['title'];
    artist = json['artist'];
    active = json['active'];
    status = json['status'];
    declineReason = json['decline_reason'];
    dateDecline = json['date_decline'];
    dateAccepted = json['date_accepted'];
    dateLastInvite = json['date_last_invite'];
    dateStart = json['date_start'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idRelease'] = idRelease;
    data['cover_url'] = coverUrl;
    data['title'] = title;
    data['artist'] = artist;
    data['status'] = status;
    data['active'] = active;
    data['decline_reason'] = declineReason;
    data['date_decline'] = dateDecline;
    data['date_accepted'] = dateAccepted;
    data['date_last_invite'] = dateLastInvite;
    data['date_start'] = dateStart;
    data['date_created'] = dateCreated;
    data['date_modified'] = dateModified;
    return data;
  }
}

class Roles {
  String? id;
  String? name;

  Roles({this.id, this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Track {
  String? id;
  String? trackNumber;
  String? artist;
  String? title;
  String? currency;
  double? amount;
  List<String>? shares;
  List<String>? relations;
  List<PartnersV2>? partnersV2;

  Track(
      {this.id,
      this.trackNumber,
      this.artist,
      this.title,
      this.currency,
      this.amount,
      this.shares,
      this.relations,
      this.partnersV2});

  Track.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackNumber = json['trackNumber'].toString();
    artist = json['artist'];
    title = json['title'] != null
        ? json['title'].toString().split("").join(String.fromCharCode(8203))
        : json['title'];
    currency = json['currency'];
    amount = json['amount'];
    shares = json['shares'] != null ? json['shares'].cast<String>() : [];
    relations =
        json['relations'] != null ? json['relations'].cast<String>() : [];
    if (json['partners_v2'] != null) {
      partnersV2 = <PartnersV2>[];
      json['partners_v2'].forEach((v) {
        partnersV2!.add(PartnersV2.fromJson(v));
      });
    } else {
      partnersV2 = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trackNumber'] = trackNumber;
    data['artist'] = artist;
    data['title'] = title;
    data['currency'] = currency;
    data['amount'] = double.parse(amount!.toStringAsFixed(2));
    data['shares'] = shares;
    data['relations'] = relations;
    if (partnersV2 != null) {
      data['partners_v2'] =
          partnersV2!.map((PartnersV2 v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartnersV2 {
  String? idUserClientPartner;
  String? relation;
  String? shares;

  PartnersV2({this.idUserClientPartner, this.relation, this.shares});

  PartnersV2.fromJson(Map<String, dynamic> json) {
    idUserClientPartner = json['idUserClientPartner'];
    relation = json['relation'];
    shares = json['shares'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUserClientPartner'] = idUserClientPartner;
    data['relation'] = relation;
    data['shares'] = shares;
    return data;
  }
}
