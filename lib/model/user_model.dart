class UserModel {
  String? profilePicture;
  String? email;
  String? firstName;
  String? lastName;
  String? language;
  String? website;
  String? country;
  String? countryId;
  int? notificationsCount;
  int? trendsEndDate;
  int? registeredDateTimestamp;
  String? sinceBegin;
  String? primaryBalanceAmount;
  String? primaryBalanceCurrency;
  String? accountType;
  int? endDate;
  String? phoneNumber;
  bool? isLeadUser;
  String? streetNumber;
  String? timezone;
  String? postCodeCity;
  bool? vatApplicable;
  String? vatNumber;
  bool? isBillingAddressEnabled;
  String? billingCompany;
  String? billingFirstName;
  String? billingLastName;
  String? billingStreetNumber;
  String? billingPostalCodeCity;
  String? billingCountryId;
  String? artistName;
  String? bandName;
  String? labelName;
  String? labelCode;
  String? userEmail;
  bool? isProfileComplete;

  bool get isDemoUser =>
      email == "demo@igroovemusic.com" || email == "hazl.hill@igroove.ch";

  UserModel(
      {this.profilePicture,
      this.email,
      this.firstName,
      this.lastName,
      this.notificationsCount,
      this.primaryBalanceAmount,
      this.registeredDateTimestamp,
      this.sinceBegin,
      this.accountType,
      this.country,
      this.language,
      this.primaryBalanceCurrency,
      this.endDate,
      this.isLeadUser,
      this.phoneNumber,
      this.website,
      this.countryId,
      this.postCodeCity,
      this.trendsEndDate,
      this.artistName,
      this.bandName,
      this.labelName,
      this.labelCode,
      this.userEmail,
      this.streetNumber,
      this.timezone,
      this.vatApplicable,
      this.vatNumber,
      this.isBillingAddressEnabled,
      this.billingCompany,
      this.billingFirstName,
      this.billingLastName,
      this.billingStreetNumber,
      this.billingPostalCodeCity,
      this.billingCountryId,
      this.isProfileComplete});

  UserModel.fromJson(Map<String, dynamic> json) {
    profilePicture = json['profile_picture'];
    email = json['email'];
    language = json['lang'] ?? "en";
    firstName = json['first_name'] ?? json['firstname'];
    lastName = json['last_name'] ?? json['lastname'];
    sinceBegin = json['since_begin'];
    notificationsCount = json['notifications'];
    isProfileComplete = json['is_profile_complete'] == 1 ? true : false;
    accountType = json['accountType'];
    registeredDateTimestamp = json['registered'] != null
        ? int.parse(json['registered'])
        : int.parse("1555600473");
    primaryBalanceAmount = json['primary_balance_amount'];
    primaryBalanceCurrency = json['primary_balance_currency'];
    endDate = json['trends_end_date'];
    isLeadUser = json['is_lead_user'] ?? false;
    artistName = json['artistName'];
    bandName = json['bandName'];
    labelName = json['labelName'];
    labelCode = json['labelCode'];
    userEmail = json['user_email'];
    phoneNumber = json['phoneNumber'];
    website = json['website'];
    countryId = json['idCountry'];
    country = json['country'];
    streetNumber = json['streetNumber'];
    timezone = json['timezone'];
    postCodeCity = json['postalCodeCity'];
    vatApplicable = json['vat_applicable'] == '1' ? true : false;
    vatNumber = json['vat_number'];
    isBillingAddressEnabled =
        json['isBillingAddressEnabled'] == '1' ? true : false;
    billingCompany = json['billingCompany'];
    billingFirstName = json['billingFirstName'];
    billingLastName = json['billingLastName'];
    billingStreetNumber = json['billingStreetNumber'];
    billingPostalCodeCity = json['billingPostalCodeCity'];
    billingCountryId = json['billingCountryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_picture'] = profilePicture;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['since_begin'] = sinceBegin;
    data['registered'] = registeredDateTimestamp.toString();
    data['trends_end_date'] = trendsEndDate;
    data['lang'] = language;
    data['is_profile_complete'] = isProfileComplete == true ? 1 : 0;
    data['notifications'] = notificationsCount;
    data['primary_balance_amount'] = primaryBalanceAmount;
    data['primary_balance_currency'] = primaryBalanceCurrency;
    data['trends_end_date'] = trendsEndDate;
    data['is_lead_user'] = isLeadUser;
    data['email'] = email;
    data['accountType'] = accountType;
    data['artistName'] = artistName;
    data['bandName'] = bandName;
    data['labelName'] = labelName;
    data['labelCode'] = labelCode;
    data['user_email'] = userEmail;
    data['website'] = website;
    data['idCountry'] = countryId;
    data['country'] = country;
    data['streetNumber'] = streetNumber;
    data['timezone'] = timezone;
    data['postalCodeCity'] = postCodeCity;
    data['vat_applicable'] = vatApplicable;
    data['vat_number'] = vatNumber;
    data['isBillingAddressEnabled'] = isBillingAddressEnabled;
    data['billingCompany'] = billingCompany;
    data['billingFirstName'] = billingFirstName;
    data['billingLastName'] = billingLastName;
    data['billingStreetNumber'] = billingStreetNumber;
    data['billingPostalCodeCity'] = billingPostalCodeCity;
    data['billingCountryId'] = billingCountryId;
    return data;
  }

  UserModel copyWith({
    String? profilePicture,
    String? email,
    String? firstName,
    String? lastName,
    String? language,
    String? website,
    String? countryId,
    String? country,
    String? phoneNumber,
    int? notificationsCount,
    int? trendsEndDate,
    int? isProfileComplete,
    int? registeredDateTimestamp,
    String? sinceBegin,
    String? primaryBalanceAmount,
    String? primaryBalanceCurrency,
    String? accountType,
    int? endDate,
    bool? isLeadUser,
    String? streetNumber,
    String? timezone,
    String? postCodeCity,
    bool? vatApplicable,
    String? vatNumber,
    bool? isBillingAddressEnabled,
    String? billingCompany,
    String? billingFirstName,
    String? billingLastName,
    String? billingStreetNumber,
    String? billingPostalCodeCity,
    String? billingCountryId,
    String? artistName,
    String? bandName,
    String? labelName,
    String? labelCode,
    String? userEmail,
  }) {
    return UserModel(
      profilePicture: profilePicture ?? this.profilePicture,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      language: language ?? this.language,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isProfileComplete: isProfileComplete as bool? ?? this.isProfileComplete,
      website: website ?? this.website,
      country: country ?? this.country,
      countryId: countryId ?? this.countryId,
      notificationsCount: notificationsCount ?? this.notificationsCount,
      trendsEndDate: trendsEndDate ?? this.trendsEndDate,
      registeredDateTimestamp:
          registeredDateTimestamp ?? this.registeredDateTimestamp,
      sinceBegin: sinceBegin ?? this.sinceBegin,
      primaryBalanceAmount: primaryBalanceAmount ?? this.primaryBalanceAmount,
      primaryBalanceCurrency:
          primaryBalanceCurrency ?? this.primaryBalanceCurrency,
      accountType: accountType ?? this.accountType,
      endDate: endDate ?? this.endDate,
      isLeadUser: isLeadUser ?? this.isLeadUser,
      streetNumber: streetNumber ?? this.streetNumber,
      timezone: timezone ?? this.timezone,
      postCodeCity: postCodeCity ?? this.postCodeCity,
      vatApplicable: vatApplicable ?? this.vatApplicable,
      vatNumber: vatNumber ?? this.vatNumber,
      isBillingAddressEnabled:
          isBillingAddressEnabled ?? this.isBillingAddressEnabled,
      billingCompany: billingCompany ?? this.billingCompany,
      billingFirstName: billingFirstName ?? this.billingFirstName,
      billingLastName: billingLastName ?? this.billingLastName,
      billingStreetNumber: billingStreetNumber ?? this.billingStreetNumber,
      billingPostalCodeCity:
          billingPostalCodeCity ?? this.billingPostalCodeCity,
      billingCountryId: billingCountryId ?? this.billingCountryId,
      artistName: artistName ?? this.artistName,
      bandName: bandName ?? this.bandName,
      labelName: labelName ?? this.labelName,
      labelCode: labelCode ?? this.labelCode,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}

class Notifications {
  int? id;
  int? dateAddedTimestamp;
  int? type;
  int? seenAtTimestamp;
  String? dateAdded;
  String? title;
  String? content;
  String? description;
  AttachmentUrl? attachmentUrl;
  String? seenAt;
  String? idUserAdmin;
  String? adminName;
  String? notificationCover;
  String? dynamicLink;
  String? iconLink;
  String? iconText;
  String? iconColor;

  Notifications({
    this.id,
    this.dateAdded,
    this.dateAddedTimestamp,
    this.title,
    this.type,
    this.content,
    this.description,
    this.attachmentUrl,
    this.seenAt,
    this.seenAtTimestamp,
    this.idUserAdmin,
    this.adminName,
    this.iconText,
    this.iconLink,
    this.iconColor,
    this.notificationCover,
    this.dynamicLink,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateAdded = json['date_added'];
    dateAddedTimestamp = json['date_added_timestamp'];
    title = json['title'];
    type = json['type'];
    content = json['content'];
    attachmentUrl = json['attachment_url'] != null
        ? AttachmentUrl.fromJson(json['attachment_url'])
        : null;
    seenAt = json['seen_at'];
    seenAtTimestamp = json['seen_at_timestamp'];
    idUserAdmin = json['idUserAdmin'].toString();
    description = json['description'].toString();
    adminName = json['admin_name'].toString();
    iconColor = json['icon_color'].toString();
    iconLink = json['icon_link'].toString();
    iconText = json['icon_text'].toString();
    notificationCover = json['notification_cover'];
    dynamicLink = json['dynamic_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_added'] = dateAdded;
    data['date_added_timestamp'] = dateAddedTimestamp;
    data['title'] = title;
    data['type'] = type;
    data['content'] = content;
    data['description'] = description;
    if (attachmentUrl != null) {
      data['attachment_url'] = attachmentUrl!.toJson();
    }
    data['seen_at'] = seenAt;
    data['seen_at_timestamp'] = seenAtTimestamp;
    data['idUserAdmin'] = idUserAdmin;
    data['admin_name'] = adminName;
    return data;
  }
}

class AttachmentUrl {
  String? filename;
  String? ext;
  String? url;

  AttachmentUrl({this.filename, this.ext, this.url});

  AttachmentUrl.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    ext = json['ext'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['ext'] = ext;
    data['url'] = url;
    return data;
  }
}

class Timezones {
  int? status;
  Payload? payload;

  Timezones({this.status, this.payload});

  Timezones.fromJson(Map<String, dynamic> json) {
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
  List<String>? timezones;

  Payload({this.timezones});

  Payload.fromJson(Map<String, dynamic> json) {
    timezones = json['timezones'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timezones'] = timezones;
    return data;
  }
}
