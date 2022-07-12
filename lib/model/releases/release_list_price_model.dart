import 'dart:math';

class ReleasePriceModel {
  int? status;
  Payload? payload;

  ReleasePriceModel({this.status, this.payload});

  ReleasePriceModel.fromJson(Map<String, dynamic> json) {
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
  List<SongPrices>? songPrices;
  List<BundlePrices>? bundlePrices;

  Payload({this.songPrices, this.bundlePrices});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['song_prices'] != null) {
      songPrices = <SongPrices>[];
      json['song_prices'].forEach((v) {
        songPrices!.add(SongPrices.fromJson(v));
      });
    }
    if (json['bundle_prices'] != null) {
      bundlePrices = <BundlePrices>[];
      json['bundle_prices'].forEach((v) {
        bundlePrices!.add(BundlePrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (songPrices != null) {
      data['song_prices'] =
          songPrices!.map((SongPrices v) => v.toJson()).toList();
    }
    if (bundlePrices != null) {
      data['bundle_prices'] =
          bundlePrices!.map((BundlePrices v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongPrices {
  int? id;
  Price? price;

  SongPrices({this.id, this.price});

  SongPrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

class BundlePrices {
  int? id;
  Price? price;

  BundlePrices({this.id, this.price});

  BundlePrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

double truncateToDecimalPlaces(num value, int fractionalDigits) =>
    (value * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);

class Price {
  String? cHF;
  String? eUR;
  String? uSD;

  Price({this.cHF, this.eUR, this.uSD});

  Price.fromJson(Map<String, dynamic> json) {
    cHF = "CHF ${json['CHF']}";
    eUR = "EUR ${json['EUR']}";
    uSD = "USD ${json['USD']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CHF'] = cHF;
    data['EUR'] = eUR;
    data['USD'] = uSD;
    return data;
  }

  @override
  String toString() => 'Price(cHF: $cHF, eUR: $eUR, uSD: $uSD)';
}
