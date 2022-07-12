class ShopFilter {
  String? idPartner;
  String? royalties;
  String? selected;
  String? name;

  ShopFilter({this.idPartner, this.royalties, this.selected, this.name});

  ShopFilter.fromJson(Map<String, dynamic> json) {
    idPartner = json['idPartner'];
    royalties = json['royalties'];
    selected = json['selected'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPartner'] = idPartner;
    data['royalties'] = royalties;
    data['selected'] = selected;
    data['name'] = name;
    return data;
  }
}
