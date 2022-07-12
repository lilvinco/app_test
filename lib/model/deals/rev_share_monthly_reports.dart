class MonthlyReports {
  String? currency;
  List<Balancehistory>? balancehistory;

  MonthlyReports({this.currency, this.balancehistory});

  MonthlyReports.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    if (json['balancehistory'] != null) {
      balancehistory = <Balancehistory>[];
      json['balancehistory'].forEach((v) {
        balancehistory!.add(Balancehistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    if (balancehistory != null) {
      data['balancehistory'] =
          balancehistory!.map((Balancehistory v) => v.toJson()).toList();
    }
    return data;
  }
}

class Balancehistory {
  int? id;
  int? dateCreated;
  String? periods;
  int? invoiceId;
  String? amount;
  int? partners;

  Balancehistory(
      {this.id,
      this.dateCreated,
      this.periods,
      this.invoiceId,
      this.amount,
      this.partners});

  Balancehistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    periods = json['periods'];
    invoiceId = json['invoice_id'];
    amount = double.parse(json['amount']).toStringAsFixed(2);
    partners = json['partners'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated;
    data['periods'] = periods;
    data['invoice_id'] = invoiceId;
    data['amount'] = amount;
    data['partners'] = partners;
    return data;
  }
}
