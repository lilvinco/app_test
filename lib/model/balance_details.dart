class BalanceDetails {
  int? status;
  PrimaryBalance? primaryBalance;
  Set<BalanceHistory>? balanceHistory;
  String? balanceHistoryTotal;

  BalanceDetails({
    this.status,
    this.primaryBalance,
    this.balanceHistory,
    this.balanceHistoryTotal,
  });

  BalanceDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    primaryBalance = json['primary_balance'] != null
        ? PrimaryBalance.fromJson(json['primary_balance'])
        : null;

    if (json['balance_history'] != null) {
      balanceHistory = {};
      json['balance_history'].forEach((v) {
        balanceHistory!.add(BalanceHistory.fromJson(v));
      });
    }

    balanceHistoryTotal = json['balance_history_total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (primaryBalance != null) {
      data['primary_balance'] = primaryBalance!.toJson();
    }
    if (balanceHistory != null) {
      data['balance_history'] =
          balanceHistory!.map((BalanceHistory v) => v.toJson()).toList();
    }
    data['balance_history_total'] = balanceHistoryTotal;
    return data;
  }

  void updateInstance(BalanceDetails newData) {
    balanceHistory!.addAll(newData.balanceHistory ?? []);
    status = newData.status;
    balanceHistoryTotal = newData.balanceHistoryTotal;
    primaryBalance = newData.primaryBalance;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BalanceDetails &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          primaryBalance == other.primaryBalance &&
          balanceHistory == other.balanceHistory &&
          balanceHistoryTotal == other.balanceHistoryTotal;

  @override
  int get hashCode =>
      status.hashCode ^
      primaryBalance.hashCode ^
      balanceHistory.hashCode ^
      balanceHistoryTotal.hashCode;
}

class PrimaryBalance {
  String? id;
  String? idUser;
  String? dateModified;
  String? currency;
  String? balance;
  String? primaryBalance;

  PrimaryBalance(
      {this.id,
      this.idUser,
      this.dateModified,
      this.currency,
      this.balance,
      this.primaryBalance});

  PrimaryBalance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    dateModified = json['date_modified'];
    currency = json['currency'];
    balance = json['balance'];
    primaryBalance = json['primary_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['date_modified'] = dateModified;
    data['currency'] = currency;
    data['balance'] = balance;
    data['primary_balance'] = primaryBalance;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrimaryBalance &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          idUser == other.idUser &&
          dateModified == other.dateModified &&
          currency == other.currency &&
          balance == other.balance &&
          primaryBalance == other.primaryBalance;

  @override
  int get hashCode =>
      id.hashCode ^
      idUser.hashCode ^
      dateModified.hashCode ^
      currency.hashCode ^
      balance.hashCode ^
      primaryBalance.hashCode;
}

class BalanceHistory {
  String? title;
  String? debit;
  String? credit;
  String? balance;
  String? tab;
  String? date;
  String? currency;
  String? reportTitle;
  String? year;
  String? month;
  String? attachment;
  String? id;
  bool? hasAttachment;
  List<ReportInvoices>? reportInvoices;

  BalanceHistory({
    this.title,
    this.debit,
    this.credit,
    this.balance,
    this.date,
    this.currency,
    this.reportTitle,
    this.tab,
    this.month,
    this.year,
    this.hasAttachment,
  });

  BalanceHistory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    debit = json['debit'];
    id = json['id'].toString();
    credit = json['credit'];
    balance = json['balance'];
    tab = json['tab'].toString();
    date = json['date'];
    reportTitle = json['report_title'] ?? "";
    currency = json['currency'];
    month = json['month'].toString();
    year = json['year'].toString();
    attachment = json['attachment'];
    hasAttachment = json['has_attachment'];

    if (json['report_invoices'] != null) {
      reportInvoices = <ReportInvoices>[];
      json['report_invoices'].forEach((v) {
        reportInvoices!.add(ReportInvoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['debit'] = debit;
    data['credit'] = credit;
    data['balance'] = balance;
    data['report_title'] = reportTitle;
    data['tab'] = tab;
    data['date'] = date;
    data['currency'] = currency;
    data['month'] = month;
    data['year'] = year;
    data['has_attachment'] = hasAttachment;

    if (reportInvoices != null) {
      data['report_invoices'] =
          reportInvoices!.map((ReportInvoices v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BalanceHistory &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          debit == other.debit &&
          credit == other.credit &&
          balance == other.balance &&
          tab == other.tab &&
          date == other.date &&
          currency == other.currency &&
          reportTitle == other.reportTitle &&
          year == other.year &&
          month == other.month &&
          attachment == other.attachment &&
          id == other.id &&
          hasAttachment == other.hasAttachment &&
          reportInvoices == other.reportInvoices;

  @override
  int get hashCode =>
      title.hashCode ^
      debit.hashCode ^
      credit.hashCode ^
      balance.hashCode ^
      tab.hashCode ^
      date.hashCode ^
      currency.hashCode ^
      reportTitle.hashCode ^
      year.hashCode ^
      month.hashCode ^
      attachment.hashCode ^
      id.hashCode ^
      hasAttachment.hashCode ^
      reportInvoices.hashCode;
}

class ReportInvoices {
  int? id;
  String? invoiceTitle;
  String? invoiceArtist;
  String? invoiceDate;
  String? currency;
  String? dateCreated;
  String? datePaid;
  String? total;
  int? pdfGenerated;

  ReportInvoices(
      {this.id,
      this.invoiceTitle,
      this.invoiceArtist,
      this.invoiceDate,
      this.currency,
      this.dateCreated,
      this.datePaid,
      this.total,
      this.pdfGenerated});

  ReportInvoices.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    invoiceTitle = json['invoice_title'];
    invoiceArtist = json['invoice_artist'];
    invoiceDate = json['invoice_date'];
    currency = json['currency'];
    dateCreated = json['date_created'];
    datePaid = json['date_paid'];
    total = json['total'];
    pdfGenerated = json['pdf_generated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['invoice_title'] = invoiceTitle;
    data['invoice_artist'] = invoiceArtist;
    data['invoice_date'] = invoiceDate;
    data['currency'] = currency;
    data['date_created'] = dateCreated;
    data['date_paid'] = datePaid;
    data['total'] = total;
    data['pdf_generated'] = pdfGenerated;
    return data;
  }
}
