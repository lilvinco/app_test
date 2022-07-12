class InvoicesData {
  String? currency;
  List<Invoice>? invoices;

  InvoicesData({this.currency, this.invoices});

  InvoicesData.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    if (json['invoices'] != null) {
      invoices = <Invoice>[];
      json['invoices'].forEach((v) {
        invoices!.add(Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    if (invoices != null) {
      data['invoices'] = invoices!.map((Invoice v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoice {
  int? id;
  int? dateCreated;
  String? ucLastname;
  String? ucFirstname;
  String? ucpLastname;
  String? ucpFirstname;
  String? clientCompany;
  String? company;
  int? invoiceId;
  String? revCount;

  Invoice(
      {this.id,
      this.dateCreated,
      this.ucLastname,
      this.ucFirstname,
      this.ucpLastname,
      this.ucpFirstname,
      this.clientCompany,
      this.company,
      this.invoiceId,
      this.revCount});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    ucLastname = json['uc_lastname'];
    ucFirstname = json['uc_firstname'];
    ucpLastname = json['ucp_lastname'];
    ucpFirstname = json['ucp_firstname'];
    clientCompany = json['client_company'];
    company = json['company'];
    invoiceId = json['invoice_id'];
    revCount = double.parse(json['rev_count']).toStringAsFixed(2);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated;
    data['uc_lastname'] = ucLastname;
    data['uc_firstname'] = ucFirstname;
    data['ucp_lastname'] = ucpLastname;
    data['ucp_firstname'] = ucpFirstname;
    data['client_company'] = clientCompany;
    data['company'] = company;
    data['invoice_id'] = invoiceId;
    data['rev_count'] = revCount;
    return data;
  }
}
