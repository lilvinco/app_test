class DealNewPartner {
  int? idPartner;
  String? firstname;
  String? lastname;
  String? email;
  String? picture;
  bool? hasActiveDeal;

  DealNewPartner({
    this.idPartner,
      this.firstname,
      this.lastname,
      this.email,
      this.picture,
    this.hasActiveDeal,
  });

  DealNewPartner.fromJson(Map<String, dynamic> json) {
    idPartner = json['idPartner'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    picture = json['picture'];
    hasActiveDeal = json['hasActiveDeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPartner'] = idPartner;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['picture'] = picture;
    data['hasActiveDeal'] = hasActiveDeal;
    return data;
  }
}
