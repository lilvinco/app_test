class AdvanceDetails {
  Details? details;
  List<Release>? releases;
  List<Transaction>? transactions;

  AdvanceDetails({this.details, this.releases, this.transactions});

  AdvanceDetails.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    if (json['releases'] != null) {
      releases = <Release>[];
      json['releases'].forEach((v) {
        releases!.add(Release.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transaction>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.toJson();
    }
    if (releases != null) {
      data['releases'] = releases!.map((Release v) => v.toJson()).toList();
    }
    if (transactions != null) {
      data['transactions'] =
          transactions!.map((Transaction v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? dateContract;
  String? contributorName;
  String? contractNumber;
  String? totalCredit;
  String? totalDebit;
  String? contractDuration;
  String? repaidPercentage;
  String? advanceAmount;
  String? dealName;
  String? dealDisplayName;
  String? status;
  String? recordings;
  ReleaseCounts? releaseCounts;
  StatusText? statusText;
  String? downloadUrl;

  Details({
    this.dateContract,
    this.contributorName,
    this.contractNumber,
    this.totalCredit,
    this.advanceAmount,
    this.dealName,
    this.contractDuration,
    this.dealDisplayName,
    this.status,
    this.recordings,
    this.releaseCounts,
    this.statusText,
    this.downloadUrl,
    this.repaidPercentage,
    this.totalDebit,
  });

  Details.fromJson(Map<String, dynamic> json) {
    dateContract = json['date_contract'];
    contributorName = json['contributor_name'];
    contractNumber = json['contract_number'];
    totalCredit = json['total_credit'];
    totalDebit = json['total_debit'];
    contractDuration = json['contract_duration'];
    repaidPercentage = json['repaid_percentage'];
    advanceAmount = json['advance_amount'];
    dealName = json['deal_name'];
    dealDisplayName = json['deal_display_name'];
    status = json['status'];
    recordings = json['recordings'];
    releaseCounts = json['release_counts'] != null
        ? ReleaseCounts.fromJson(json['release_counts'])
        : null;
    statusText = json['status_text'] != null
        ? StatusText.fromJson(json['status_text'])
        : null;
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_contract'] = dateContract;
    data['contributor_name'] = contributorName;
    data['contract_number'] = contractNumber;
    data['total_credit'] = totalCredit;
    data['total_debit'] = totalDebit;
    data['contract_duration'] = contractDuration;
    data['repaid_percentage'] = repaidPercentage;
    data['advance_amount'] = advanceAmount;
    data['deal_name'] = dealName;
    data['deal_display_name'] = dealDisplayName;
    data['status'] = status;
    data['recordings'] = recordings;
    if (releaseCounts != null) {
      data['release_counts'] = releaseCounts!.toJson();
    }
    if (statusText != null) {
      data['status_text'] = statusText!.toJson();
    }
    data['download_url'] = downloadUrl;
    return data;
  }
}

class ReleaseCounts {
  String? singles;
  String? albums;
  String? all;

  ReleaseCounts({this.singles, this.albums, this.all});

  ReleaseCounts.fromJson(Map<String, dynamic> json) {
    singles = json['singles'];
    albums = json['albums'];
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['singles'] = singles;
    data['albums'] = albums;
    data['all'] = all;
    return data;
  }
}

class StatusText {
  String? label;
  String? classAdmin;
  String? statusClass;

  StatusText({this.label, this.classAdmin, this.statusClass});

  StatusText.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    classAdmin = json['class-admin'];
    statusClass = json['class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['class-admin'] = classAdmin;
    data['class'] = statusClass;
    return data;
  }
}

class Release {
  String? title;
  String? artist;
  String? cover;
  String? totalAmount;

  Release({this.title, this.artist, this.cover, this.totalAmount});

  Release.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null
        ? json['title'].toString().split("").join(String.fromCharCode(8203))
        : json['title'];
    artist = json['artist'];
    cover = json['cover_url'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['artist'] = artist;
    data['cover_url'] = cover;
    data['total_amount'] = totalAmount;
    return data;
  }
}

class Transaction {
  int? dateAdded;
  int? id;
  int? type;
  String? title;
  String? debit;
  String? credit;
  String? balance;
  String? attachment;

  Transaction({
    this.dateAdded,
    this.type,
    this.id,
    this.title,
    this.debit,
    this.credit,
    this.balance,
    this.attachment,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    dateAdded = json['date_added'] != null ? json['date_added'] * 1000 : null;
    type = json['type'];
    id = json['id'];
    attachment = json['attachment'];
    title = json['title'] != null
        ? json['title'].toString().split("").join(String.fromCharCode(8203))
        : json['title'];
    debit = json['debit'];
    credit = json['credit'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_added'] = dateAdded != null ? dateAdded! / 1000 : dateAdded;
    data['type'] = type;
    data['title'] = title;
    data['debit'] = debit;
    data['id'] = id;
    data['credit'] = credit;
    data['balance'] = balance;
    data['attachment'] = attachment;

    return data;
  }
}
