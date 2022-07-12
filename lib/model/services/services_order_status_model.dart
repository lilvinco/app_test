class ServicesOrderStatusModel {
  int? status;
  String? paymentStatus;
  int? paymentCompleted;

  ServicesOrderStatusModel(
      {this.status, this.paymentStatus, this.paymentCompleted});

  ServicesOrderStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    paymentCompleted = json['paymentCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['paymentStatus'] = paymentStatus;
    data['paymentCompleted'] = paymentCompleted;
    return data;
  }
}
