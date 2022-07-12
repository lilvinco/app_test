class ReleaseListArtistRoleModel {
  int? status;
  Payload? payload;

  ReleaseListArtistRoleModel({this.status, this.payload});

  ReleaseListArtistRoleModel.fromJson(Map<String, dynamic> json) {
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
  List<Roles>? roles;
  List<DeprecatedRoles>? deprecatedRoles;

  Payload({this.roles, this.deprecatedRoles});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    if (json['deprecated_roles'] != null) {
      deprecatedRoles = <DeprecatedRoles>[];
      json['deprecated_roles'].forEach((v) {
        deprecatedRoles!.add(DeprecatedRoles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roles != null) {
      data['roles'] = roles!.map((Roles v) => v.toJson()).toList();
    }
    if (deprecatedRoles != null) {
      data['deprecated_roles'] =
          deprecatedRoles!.map((DeprecatedRoles v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  String? id;
  String? name;

  Roles({this.id, this.name});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class DeprecatedRoles {
  String? id;
  String? name;

  DeprecatedRoles({this.id, this.name});

  DeprecatedRoles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
