import 'package:igroove_fan_box_one/core/services/user_service.dart';

class FanBoxesModel {
  int? status;
  List<DigitalFanBoxes>? digitalFanBoxes;

  FanBoxesModel({this.status, this.digitalFanBoxes});

  FanBoxesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payload'] != null) {
      digitalFanBoxes = <DigitalFanBoxes>[];
      json['payload'].forEach((v) {
        digitalFanBoxes!.add(DigitalFanBoxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (digitalFanBoxes != null) {
      data['payload'] = digitalFanBoxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
