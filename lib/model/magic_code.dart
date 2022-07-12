class MagicCode {
  int? status;
  MagicCodeData? data;

  MagicCode({this.status, this.data});

  MagicCode.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['payload'] != null
        ? MagicCodeData.fromJson(json['payload'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['payload'] = this.data!.toJson();
    }
    return data;
  }
}

class MagicCodeData {
  String? magicCode;
  String? email;
  String? firstname;
  String? lastname;
  String? company;
  String? streetNumber;
  String? postalCodeCity;
  String? idCountry;
  String? lang;

  MagicCodeData(
      {this.magicCode,
      this.email,
      this.firstname,
      this.lastname,
      this.company,
      this.streetNumber,
      this.postalCodeCity,
      this.idCountry,
      this.lang});

  MagicCodeData.fromJson(Map<String, dynamic> json) {
    magicCode = json['magic_code'].toString();
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    company = json['company'];
    streetNumber = json['streetNumber'];
    postalCodeCity = json['postalCodeCity'];
    idCountry = json['idCountry'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['magic_code'] = magicCode;
    data['email'] = email;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['company'] = company;
    data['streetNumber'] = streetNumber;
    data['postalCodeCity'] = postalCodeCity;
    data['idCountry'] = idCountry;
    data['lang'] = lang;

    return data;
  }
}
