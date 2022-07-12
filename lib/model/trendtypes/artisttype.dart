class ArtistFilter {
  String? idContributor;
  String? royalties;
  String? selected;
  String? artistName;

  ArtistFilter(
      {this.idContributor, this.royalties, this.selected, this.artistName});

  ArtistFilter.fromJson(Map<String, dynamic> json) {
    idContributor = json['idContributor'];
    royalties = json['royalties'];
    selected = json['selected'];
    artistName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idContributor'] = idContributor;
    data['royalties'] = royalties;
    data['selected'] = selected;
    data['artistName'] = artistName;
    return data;
  }
}
