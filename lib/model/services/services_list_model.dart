class ServicesListModel {
  int? status;
  String? currency;
  List<Services>? services;

  ServicesListModel({this.status, this.currency, this.services});

  ServicesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    currency = json['currency'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['currency'] = currency;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? id;
  String? name;
  int? serviceType;
  List<Releases>? releases;
  Steps? steps;
  String? noReleaseErrorMessage;
  bool? moreInfo;
  String? picture;
  String? appMoreDescription;
  String? appPicture;
  String? quickPicture;
  String? code;
  double? priceRaw;
  String? quickDescription;
  String? priceDisplay;
  double? packageDiscountRaw;
  String? packageDiscountDisplay;
  List<Prices>? prices;

  Services(
      {this.id,
      this.name,
      this.serviceType,
      this.releases,
      this.steps,
      this.appMoreDescription,
      this.noReleaseErrorMessage,
      this.picture,
      this.quickDescription,
      this.moreInfo,
      this.appPicture,
      this.quickPicture,
      this.code,
      this.priceRaw,
      this.priceDisplay,
      this.packageDiscountRaw,
      this.packageDiscountDisplay,
      this.prices});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceType = json['serviceType'];
    if (json['releases'] != null) {
      releases = <Releases>[];
      json['releases'].forEach((v) {
        releases!.add(Releases.fromJson(v));
      });
    }
    steps = json['steps'] != null ? Steps.fromJson(json['steps']) : null;
    noReleaseErrorMessage = json['noReleaseErrorMessage'];
    picture = json['picture'];
    appMoreDescription = json['app_more_description'];
    moreInfo = json['more_info'];
    appPicture = json['app_picture'];
    quickDescription = json['quick_description'];
    quickPicture = json['quick_picture'];
    code = json['code'];
    priceRaw = double.tryParse(json['price_raw'].toString());
    priceDisplay = json['price_display'];
    packageDiscountRaw =
        double.tryParse(json['package_discount_raw'].toString());
    packageDiscountDisplay = json['package_discount_display'];
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices!.add(Prices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['app_more_description'] = appMoreDescription;
    data['serviceType'] = serviceType;
    if (releases != null) {
      data['releases'] = releases!.map((v) => v.toJson()).toList();
    }
    if (steps != null) {
      data['steps'] = steps!.toJson();
    }
    data['noReleaseErrorMessage'] = noReleaseErrorMessage;
    data['quick_description'] = quickDescription;
    data['picture'] = picture;
    data['more_info'] = moreInfo;
    data['app_picture'] = appPicture;
    data['quick_picture'] = quickPicture;
    data['code'] = code;
    data['price_raw'] = priceRaw;
    data['price_display'] = priceDisplay;
    data['package_discount_raw'] = packageDiscountRaw;
    data['package_discount_display'] = packageDiscountDisplay;
    if (prices != null) {
      data['prices'] = prices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Releases {
  String? idRelease;
  String? albumTitle;
  String? artist;
  String? coverUrl;

  Releases({this.idRelease, this.albumTitle, this.artist, this.coverUrl});

  Releases.fromJson(Map<String, dynamic> json) {
    idRelease = json['idRelease'];
    albumTitle = json['album_title'];
    artist = json['artist'];
    coverUrl = json['cover_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idRelease'] = idRelease;
    data['album_title'] = albumTitle;
    data['artist'] = artist;
    data['cover_url'] = coverUrl;
    return data;
  }
}

class Steps {
  bool? release;
  bool? custom;
  bool? more;
  bool? terms;
  bool? payment;

  Steps({this.release, this.custom, this.more, this.terms, this.payment});

  Steps.fromJson(Map<String, dynamic> json) {
    release = json['release'];
    custom = json['custom'];
    more = json['more'];
    terms = json['terms'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['release'] = release;
    data['custom'] = custom;
    data['more'] = more;
    data['terms'] = terms;
    data['payment'] = payment;
    return data;
  }
}

class Prices {
  String? id;
  String? title;
  double? priceRaw;
  String? priceDisplay;
  int? shippingRaw;
  String? shippingDisplay;
  double? earningRaw;
  String? earningDisplay;
  String? rmaDescription;

  Prices(
      {this.id,
      this.title,
      this.priceRaw,
      this.priceDisplay,
      this.shippingRaw,
      this.shippingDisplay,
      this.earningRaw,
      this.earningDisplay,
      this.rmaDescription});

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceRaw = double.tryParse(json['price_raw'].toString());
    priceDisplay = json['price_display'];
    shippingRaw = json['shipping_raw'];
    shippingDisplay = json['shipping_display'];
    earningRaw = double.tryParse(json['earning_raw'].toString());
    earningDisplay = json['earning_display'];
    rmaDescription = json['rma_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price_raw'] = priceRaw;
    data['price_display'] = priceDisplay;
    data['shipping_raw'] = shippingRaw;
    data['shipping_display'] = shippingDisplay;
    data['earning_raw'] = earningRaw;
    data['earning_display'] = earningDisplay;
    data['rma_description'] = rmaDescription;
    return data;
  }
}
