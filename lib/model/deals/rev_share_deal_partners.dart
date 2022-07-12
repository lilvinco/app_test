class DealPartners {
  Details? details;
  List<Partners>? partners;

  DealPartners({
    this.details,
    this.partners,
  });

  DealPartners.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    if (json['partners'] != null) {
      partners = <Partners>[];
      json['partners'].forEach((v) {
        partners!.add(Partners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.toJson();
    }
    if (partners != null) {
      data['partners'] = partners!.map((Partners v) => v.toJson()).toList();
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
    status = json['status'];
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
    data['date_start'] = dateStart;
    data['date_created'] = dateCreated;
    data['date_modified'] = dateModified;
    return data;
  }
}

class Partners {
  String? id;
  String? firstname;
  String? lastname;
  String? company;
  String? email;
  String? dateLastInvite;
  String? dateDecline;
  String? dateAccepted;
  String? status;
  String? idUserClientPartner;
  String? active;
  String? declineReason;

  Partners(
      {this.id,
      this.firstname,
      this.lastname,
      this.company,
      this.email,
      this.dateLastInvite,
      this.dateDecline,
      this.dateAccepted,
      this.status,
      this.idUserClientPartner,
      this.active,
      this.declineReason});

  Partners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    company = json['company'];
    email = json['email'];
    dateLastInvite = json['date_last_invite'];
    dateDecline = json['date_decline'];
    dateAccepted = json['date_accepted'];
    status = json['status'];
    idUserClientPartner = json['idUserClientPartner'];
    active = json['active'];
    declineReason = json['decline_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['company'] = company;
    data['email'] = email;
    data['date_last_invite'] = dateLastInvite;
    data['date_accepted'] = dateAccepted;
    data['date_decline'] = dateDecline;
    data['status'] = status;
    data['idUserClientPartner'] = idUserClientPartner;
    data['active'] = active;
    data['decline_reason'] = declineReason;
    return data;
  }
}
