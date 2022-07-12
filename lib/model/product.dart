class Product {
  String? id;
  String? coverUrlThumb;
  String? artist;
  String? title;
  bool? hasReleaseDeal;
  bool? hasAdvanceContract;
  bool? releaseDealApplicable;
  Labels? labels;
  List<Tickets>? tickets;
  DateTime? releaseDate;
  String? mediaType;
  ReleaseStats? releaseStats;

  Product({
    this.id,
    this.coverUrlThumb,
    this.artist,
    this.title,
    this.hasReleaseDeal,
    this.hasAdvanceContract,
    this.releaseDealApplicable,
    this.labels,
    this.tickets,
    this.releaseDate,
    this.releaseStats,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coverUrlThumb = json['cover_url_thumb'];
    artist = json['artist'];
    title = json['title'];
    hasReleaseDeal = json['hasReleaseDeal'];
    hasAdvanceContract = json['hasAdvanceContract'];
    releaseDealApplicable = json['releaseDealApplicable'];
    labels = json['labels'] != null ? Labels.fromJson(json['labels']) : null;
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(Tickets.fromJson(v));
      });
    }
    mediaType = json['mediaType'];
    releaseDate = json['date_release'] != null &&
            json['date_release'] != '0' &&
            int.tryParse(json['date_release']) != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(json['date_release']) * 1000)
        : null;

    releaseStats = ReleaseStats.fromJSON(
        json['trends'] != null && json['trends'].isNotEmpty
            ? json['trends']
            : {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cover_url_thumb'] = coverUrlThumb;
    data['artist'] = artist;
    data['title'] = title;
    data['hasReleaseDeal'] = hasReleaseDeal;
    data['hasAdvanceContract'] = hasAdvanceContract;
    data['releaseDealApplicable'] = releaseDealApplicable;
    if (labels != null) {
      data['labels'] = labels!.toJson();
    }
    if (tickets != null) {
      data['tickets'] = tickets!.map((Tickets v) => v.toJson()).toList();
    }
    return data;
  }
}

class Labels {
  bool? hasTicket;
  bool? isArchived;
  bool? toBeDeleted;
  bool? notCompleted;
  bool? notApproved;

  Labels(
      {this.hasTicket,
      this.isArchived,
      this.toBeDeleted,
      this.notCompleted,
      this.notApproved});

  Labels.fromJson(Map<String, dynamic> json) {
    hasTicket = json['hasTicket'];
    isArchived = json['isArchived'];
    toBeDeleted = json['toBeDeleted'];
    notCompleted = json['notCompleted'];
    notApproved = json['notApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hasTicket'] = hasTicket;
    data['isArchived'] = isArchived;
    data['toBeDeleted'] = toBeDeleted;
    data['notCompleted'] = notCompleted;
    data['notApproved'] = notApproved;
    return data;
  }
}

class Tickets {
  String? subject;
  String? content;
  String? dateCreated;

  Tickets({this.subject, this.content, this.dateCreated});

  Tickets.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    content = json['content'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['content'] = content;
    data['date_created'] = dateCreated;
    return data;
  }
}

class ReleaseStats {
  late int streams;
  late int streamsLast30;
  String? currency;
  late double royalty;
  double? royaltyLast30;
  String? royaltyDisplay;
  String? royaltyLast30Display;

  ReleaseStats.fromJSON(Map<dynamic, dynamic> json) {
    streams = int.tryParse(json['streams'] ?? '0') ?? 0;
    streamsLast30 = int.tryParse(json['streams_last_30'] ?? '0') ?? 0;
    currency = json['currency'] ?? 'EUR';
    royalty = double.tryParse(json['royalty'] ?? '0.0') ?? 0.0;
    royaltyDisplay = json['royalty_display'] ?? '0.0';
    royaltyLast30 = double.tryParse(json['royalty_last_30'] ?? '0.0') ?? 0.0;
    royaltyLast30Display = json['royalty_last_30_display'] ?? '0.0';
  }
}
