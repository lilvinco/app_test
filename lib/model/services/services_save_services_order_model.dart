class ServicesSaveServiceOrderModel {
  int? status;
  String? message;
  int? idOrder;
  String? paymentURL;
  int? paymentNeeded;

  ServicesSaveServiceOrderModel(
      {this.status, this.message, this.idOrder, this.paymentURL});

  ServicesSaveServiceOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    idOrder = json['idOrder'];
    paymentURL = json['paymentURL'];
    paymentNeeded = json['paymentNeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['idOrder'] = idOrder;
    data['paymentURL'] = paymentURL;
    data['paymentNeeded'] = paymentNeeded;
    return data;
  }
}
