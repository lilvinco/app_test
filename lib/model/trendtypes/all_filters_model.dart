class AllFiltersModel {
   String? name;
  String? id;
  String? type;
  String? selected;

  AllFiltersModel({this.name, this.id, this.type, this.selected});

  AllFiltersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['type'] = type;
    data['selected'] = selected;
    return data;
  }
}

