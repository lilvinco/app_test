class PartnerExist {
  int? status;
  Payload? payload;

  PartnerExist({
    this.status,
    this.payload,
  });

  PartnerExist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? company;
  String? firstname;
  String? lastname;
  String? streetNumber;
  String? postalCodeCity;
  String? idCountry;
  String? customerLang;
  String? status;
  bool? allowWithholdingTax;

  Payload(
      {this.company,
      this.firstname,
      this.lastname,
      this.streetNumber,
      this.postalCodeCity,
      this.idCountry,
      this.customerLang,
      this.status,
      this.allowWithholdingTax});

  Payload.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    streetNumber = json['streetNumber'];
    postalCodeCity = json['postalCodeCity'];
    idCountry = json['idCountry'];
    customerLang = json['customer_lang'];
    status = json['status'];
    allowWithholdingTax = json['allowWithholdingTax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company'] = company;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['streetNumber'] = streetNumber;
    data['postalCodeCity'] = postalCodeCity;
    data['idCountry'] = idCountry;
    data['customer_lang'] = customerLang;
    data['status'] = status;
    data['allowWithholdingTax'] = allowWithholdingTax;
    return data;
  }
}
