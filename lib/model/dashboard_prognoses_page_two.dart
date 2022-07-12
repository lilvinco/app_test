class DashboardPrognosesPageTwo {
  int? status;
  Data? data;

  DashboardPrognosesPageTwo({this.status, this.data});

  DashboardPrognosesPageTwo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Included>? included;
  List<Excluded>? excluded;

  Data({this.included, this.excluded});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['included'] != null) {
      included = <Included>[];
      json['included'].forEach((v) {
        included!.add(Included.fromJson(v));
      });
    }
    if (json['excluded'] != null) {
      excluded = <Excluded>[];
      json['excluded'].forEach((v) {
        excluded!.add(Excluded.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (included != null) {
      data['included'] = included!.map((Included v) => v.toJson()).toList();
    }
    if (excluded != null) {
      data['excluded'] = excluded!.map((Excluded v) => v.toJson()).toList();
    }
    return data;
  }
}

class Included {
  String? idRelease;
  String? title;
  String? subtitle;
  String? fullArtist;
  String? cover;
  String? streamingQuantity;
  List<Prognoses>? prognoses;

  Included(
      {this.idRelease,
      this.title,
      this.subtitle,
      this.fullArtist,
      this.cover,
      this.streamingQuantity,
      this.prognoses});

  Included.fromJson(Map<String, dynamic> json) {
    idRelease = json['idRelease'];
    title = json['title'];
    subtitle = json['subtitle'];
    fullArtist = json['full_artist'];
    cover = json['cover'];
    streamingQuantity = json['streaming_quantity'];
    if (json['prognoses'] != null) {
      prognoses = <Prognoses>[];
      json['prognoses'].forEach((v) {
        prognoses!.add(Prognoses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idRelease'] = idRelease;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['full_artist'] = fullArtist;
    data['cover'] = cover;
    data['streaming_quantity'] = streamingQuantity;
    if (prognoses != null) {
      data['prognoses'] = prognoses!.map((Prognoses v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prognoses {
  String? timePeriod;
  String? amount;
  int? percentage;

  Prognoses({this.timePeriod, this.amount, this.percentage});

  Prognoses.fromJson(Map<String, dynamic> json) {
    timePeriod = json['time_period'];
    amount = json['amount'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_period'] = timePeriod;
    data['amount'] = amount;
    data['percentage'] = percentage;
    return data;
  }
}

class Excluded {
  String? idRelease;
  String? title;
  String? subtitle;
  String? fullArtist;
  String? cover;
  String? streamingQuantity;

  Excluded(
      {this.idRelease,
      this.title,
      this.subtitle,
      this.fullArtist,
      this.cover,
      this.streamingQuantity});

  Excluded.fromJson(Map<String, dynamic> json) {
    idRelease = json['idRelease'];
    title = json['title'];
    subtitle = json['subtitle'];
    fullArtist = json['full_artist'];
    cover = json['cover'];
    streamingQuantity = json['streaming_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idRelease'] = idRelease;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['full_artist'] = fullArtist;
    data['cover'] = cover;
    data['streaming_quantity'] = streamingQuantity;
    return data;
  }
}
