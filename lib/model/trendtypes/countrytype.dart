class CountryFilter {
  String? idCountry;
  String? royalties;
  String? selected;
  String? name;
  int? rank;

  CountryFilter(
      {this.idCountry, this.royalties, this.selected, this.name, this.rank});

  CountryFilter.fromJson(Map<String, dynamic> json) {
    idCountry = json['idCountry'];
    royalties = json['royalties'];
    selected = json['selected'];
    name = json['name'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCountry'] = idCountry;
    data['royalties'] = royalties;
    data['selected'] = selected;
    data['name'] = name;
    data['rank'] = rank;
    return data;
  }
}
