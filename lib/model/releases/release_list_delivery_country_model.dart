class ReleaseListDeliveryCountryModel {
  int? status;
  Payload? payload;

  ReleaseListDeliveryCountryModel({this.status, this.payload});

  ReleaseListDeliveryCountryModel.fromJson(Map<String, dynamic> json) {
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
  List<DeliveryCountries>? deliveryCountries;

  Payload({this.deliveryCountries});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['delivery_countries'] != null) {
      deliveryCountries = <DeliveryCountries>[];
      json['delivery_countries'].forEach((v) {
        deliveryCountries!.add(DeliveryCountries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deliveryCountries != null) {
      data['delivery_countries'] =
          deliveryCountries!.map((DeliveryCountries v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryCountries {
  String? id;
  String? name;
  String? code;

  DeliveryCountries({this.id, this.name, this.code});

  DeliveryCountries copyWith({
    String? id,
    String? name,
    String? code,
  }) {
    return DeliveryCountries(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  DeliveryCountries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryCountries &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          code == other.code;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ code.hashCode;
}
