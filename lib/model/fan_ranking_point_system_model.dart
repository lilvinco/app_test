class FanRankingPointSystem {
  int? status;
  List<PointSystem>? pointSystem;

  FanRankingPointSystem({this.status, this.pointSystem});

  FanRankingPointSystem.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payload'] != null) {
      pointSystem = <PointSystem>[];
      json['payload'].forEach((v) {
        pointSystem!.add(PointSystem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (pointSystem != null) {
      data['payload'] = pointSystem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PointSystem {
  String? key;
  String? translation;
  int? point;

  PointSystem({this.key, this.translation, this.point});

  PointSystem.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    translation = json['translation'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['translation'] = translation;
    data['point'] = point;
    return data;
  }
}
