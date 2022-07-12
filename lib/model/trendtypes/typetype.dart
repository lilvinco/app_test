class TypesFilter {
  String? idTrendType;
  String? royalties;
  String? selected;
  String? name;

  TypesFilter({this.idTrendType, this.royalties, this.selected, this.name});

  TypesFilter.fromJson(Map<String, dynamic> json) {
    idTrendType = json['idTrendType'];
    royalties = json['royalties'];
    selected = json['selected'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTrendType'] = idTrendType;
    data['royalties'] = royalties;
    data['selected'] = selected;
    data['name'] = name;
    return data;
  }
}
