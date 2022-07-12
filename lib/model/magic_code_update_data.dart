class MagicCodeUpdateData {
  int? status;
  String? authToken;
  User? user;
  AppSettings? appSettings;
  Dashboard? dashboard;

  MagicCodeUpdateData(
      {this.status,
      this.authToken,
      this.user,
      this.appSettings,
      this.dashboard});

  MagicCodeUpdateData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    authToken = json['auth_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    appSettings = json['app_settings'] != null
        ? AppSettings.fromJson(json['app_settings'])
        : null;
    dashboard = json['dashboard'] != null
        ? Dashboard.fromJson(json['dashboard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['auth_token'] = authToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (appSettings != null) {
      data['app_settings'] = appSettings!.toJson();
    }
    if (dashboard != null) {
      data['dashboard'] = dashboard!.toJson();
    }
    return data;
  }
}

class User {
  String? profilePicture;
  String? email;
  String? firstName;
  String? lastName;
  dynamic lang;
  String? registered;
  String? sinceBegin;
  int? notifications;
  int? trendsEndDate;
  bool? isLeadUser;
  String? primaryBalanceAmount;
  String? primaryBalanceCurrency;

  User(
      {this.profilePicture,
      this.email,
      this.firstName,
      this.lastName,
      this.lang,
      this.registered,
      this.sinceBegin,
      this.notifications,
      this.trendsEndDate,
      this.isLeadUser,
      this.primaryBalanceAmount,
      this.primaryBalanceCurrency});

  User.fromJson(Map<String, dynamic> json) {
    profilePicture = json['profile_picture'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    lang = json['lang'];
    registered = json['registered'];
    sinceBegin = json['since_begin'];
    notifications = json['notifications'];
    trendsEndDate = json['trends_end_date'];
    isLeadUser = json['is_lead_user'];
    primaryBalanceAmount = json['primary_balance_amount'];
    primaryBalanceCurrency = json['primary_balance_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_picture'] = profilePicture;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['lang'] = lang;
    data['registered'] = registered;
    data['since_begin'] = sinceBegin;
    data['notifications'] = notifications;
    data['trends_end_date'] = trendsEndDate;
    data['is_lead_user'] = isLeadUser;
    data['primary_balance_amount'] = primaryBalanceAmount;
    data['primary_balance_currency'] = primaryBalanceCurrency;
    return data;
  }
}

class AppSettings {
  bool? showFeedbackButton;
  bool? showRevShare;
  int? allowWithholdingTax;

  AppSettings(
      {this.showFeedbackButton, this.showRevShare, this.allowWithholdingTax});

  AppSettings.fromJson(Map<String, dynamic> json) {
    showFeedbackButton = json['showFeedbackButton'];
    showRevShare = true; //json['showRevShare'];
    allowWithholdingTax = json['allowWithholdingTax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['showFeedbackButton'] = showFeedbackButton;
    data['showRevShare'] = showRevShare;
    data['allowWithholdingTax'] = allowWithholdingTax;
    return data;
  }
}

class Dashboard {
  bool? income;
  bool? topTrends;
  bool? growth;
  bool? nextPayout;
  bool? prognoses;
  bool? age;

  Dashboard(
      {this.income,
      this.topTrends,
      this.growth,
      this.nextPayout,
      this.prognoses,
      this.age});

  Dashboard.fromJson(Map<String, dynamic> json) {
    income = json['Income'];
    topTrends = json['TopTrends'];
    growth = json['Growth'];
    nextPayout = json['NextPayout'];
    prognoses = json['Prognoses'];
    age = json['Age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Income'] = income;
    data['TopTrends'] = topTrends;
    data['Growth'] = growth;
    data['NextPayout'] = nextPayout;
    data['Prognoses'] = prognoses;
    data['Age'] = age;
    return data;
  }
}
