class AppSettings {
  bool? showFeedbackButton;
  bool? showRevShare;
  bool? showPayPalPayoutForm;
  int? allowWithholdingTax;
  bool? showDashboard;
  bool? hasInternationalBanking;
  String? revShareCurrency;
  String? revShareFeesActivated;
  String? revShareFeeAmount;
  bool? hasModificationFee;
  double? modificationFee;

  AppSettings(
      {this.showFeedbackButton,
      this.showRevShare,
      this.hasModificationFee,
      this.modificationFee,
      this.allowWithholdingTax,
      this.showPayPalPayoutForm,
      this.hasInternationalBanking,
      this.showDashboard,
      this.revShareCurrency,
      this.revShareFeeAmount,
      this.revShareFeesActivated});

  AppSettings.fromJson(Map<String, dynamic> json) {
    showFeedbackButton = json['showFeedbackButton'] ?? false;
    showRevShare = json['showRevShare'] ?? false;
    hasModificationFee = json['hasModificationFee'] ?? false;
    hasInternationalBanking = json['hasInternationalBanking'] ?? false;
    modificationFee =
        double.tryParse(json['modificationFee'].toString()) ?? 0.0;
    allowWithholdingTax = json['allowWithholdingTax'] ?? 0;
    showPayPalPayoutForm = json['showPayPalPayoutForm'] ?? false;
    showDashboard = json['showDashboard'] ?? false;
    revShareCurrency = json['revShareFeeCurrency'].toString();
    revShareFeeAmount = json['revShareFeeAmount'].toString();
    revShareFeesActivated = json['revShareFeeActivated'].toString();
  }
}
