class ReleasePaymentDetails {
  int? status;
  Payload? payload;

  ReleasePaymentDetails({this.status, this.payload});

  ReleasePaymentDetails.fromJson(Map<String, dynamic> json) {
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
  bool? hasOpenAdditionalServices;
  double? grandTotal;
  double? total;
  double? toBePaid;
  double? totalPaid;
  double? vatPercent;
  String? currency;
  double? withoutVat;
  double? discount;

  double? vat;
  List<Items>? items;

  Payload(
      {this.total,
      this.hasOpenAdditionalServices,
      this.grandTotal,
      this.toBePaid,
      this.totalPaid,
      this.vatPercent,
      this.currency,
      this.withoutVat,
      this.vat,
      this.discount,
      this.items});

  Payload.fromJson(Map<String, dynamic> json) {
    total = double.tryParse(json['total'].toString());
    toBePaid = double.tryParse(json['to_be_paid'].toString());
    grandTotal = double.tryParse(json['grand_total'].toString());
    totalPaid = double.tryParse(json['total_paid'].toString());
    vatPercent = double.tryParse(json['vat_percent'].toString());
    currency = json['currency'];
    hasOpenAdditionalServices = json['has_open_additional_services'];
    withoutVat = double.tryParse(json['without_vat'].toString());
    vat = double.tryParse(json['vat'].toString());
    discount = double.tryParse(json['discount'].toString());
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['has_open_additional_services'] = hasOpenAdditionalServices;
    data['to_be_paid'] = toBePaid;
    data['total_paid'] = totalPaid;
    data['vat_percent'] = vatPercent;
    data['currency'] = currency;
    data['without_vat'] = withoutVat;
    data['vat'] = vat;
    data['discount'] = discount;
    if (items != null) {
      data['items'] = items!.map((Items v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? title;
  String? title2;
  double? itemValue;
  double? totalValue;
  String? currency;
  int? status;

  Items(
      {this.id,
      this.title,
      this.itemValue,
      this.totalValue,
      this.currency,
      this.status});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    title2 = json['title2'];
    status = int.tryParse(json['status']);
    itemValue = double.tryParse(json['item_value'].toString());
    totalValue = double.tryParse(json['total_value'].toString());
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['title2'] = title2;
    data['status'] = status;
    data['item_value'] = itemValue;
    data['total_value'] = totalValue;
    data['currency'] = currency;
    return data;
  }
}
