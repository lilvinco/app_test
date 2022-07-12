class DealCountry {
  String? id;
  String? country;
  String? currency;
  String? continent;
  String? code;
  String? codeIso3;
  String? lat;
  String? lon;
  String? vatDigital;
  String? vatPhysical;
  String? vatLicensing;
  String? vatRevShare;
  String? canRegisterFrom;

  DealCountry({
    this.id,
      this.country,
      this.currency,
      this.continent,
      this.code,
      this.codeIso3,
      this.lat,
      this.lon,
      this.vatDigital,
      this.vatPhysical,
      this.vatLicensing,
      this.vatRevShare,
    this.canRegisterFrom,
  });

  DealCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    currency = json['currency'];
    continent = json['continent'];
    code = json['code'];
    codeIso3 = json['code_iso3'];
    lat = json['lat'];
    lon = json['lon'];
    vatDigital = json['vat_digital'];
    vatPhysical = json['vat_physical'];
    vatLicensing = json['vat_licensing'];
    vatRevShare = json['vat_rev_share'];
    canRegisterFrom = json['can_register_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country'] = country;
    data['currency'] = currency;
    data['continent'] = continent;
    data['code'] = code;
    data['code_iso3'] = codeIso3;
    data['lat'] = lat;
    data['lon'] = lon;
    data['vat_digital'] = vatDigital;
    data['vat_physical'] = vatPhysical;
    data['vat_licensing'] = vatLicensing;
    data['vat_rev_share'] = vatRevShare;
    data['can_register_from'] = canRegisterFrom;
    return data;
  }
}