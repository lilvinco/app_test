import 'dart:io';

import 'package:collection/collection.dart';
import 'package:igroove_fan_box_one/model/releases/release_list_artist_model.dart';
import 'package:igroove_fan_box_one/model/releases/release_list_delivery_country_model.dart';

class ReleaseDetailModel {
  int? status;
  ReleaseDetails? payload;

  ReleaseDetailModel({this.status, this.payload});

  ReleaseDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    payload = json['payload'] != null
        ? ReleaseDetails.fromJson(json['payload'])
        : null;
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

class ReleaseDetails {
  String? id;

  // add == operator
  List<Genres>? genres;
  String? dealName;
  String? idUser;
  String? idDeal;
  String? idPremiumDeal;
  String? productType;

  // add == operator
  SongPrice? songPrice;
  String? idSongPrice;

  // add == operator
  BundlePrice? bundlePrice;
  String? idBundlePrice;
  DateTime? dateAdded;
  String? dateModified;
  String? dateArchived;
  DateTime? dateRelease;
  DateTime? datePreorder;
  DateTime? dateStreaming;
  DateTime? dateReleaseOriginal;
  String? dateApproved;
  String? cover;
  String? releaseTime;
  String? title;
  String? titleVersion;

  // add == operator
  List<Artists>? artist;
  String? displayArtist;

  // add == operator
  List<Artists>? featuring;
  String? label;
  String? eanCode;
  String? sEanCode;
  String? language;
  String? cYear;
  String? cName;
  String? pYear;
  String? pName;
  int? mediaType;
  String? explicitContent;

  // add == operator
  StatusesArr? statusesArr;
  String? archived;
  String? approved;
  String? toDelete;
  String? locked;
  String? trackCount;
  String? audioBook;
  String? trendFirstSale;
  String? currency;
  String? artists;
  String? firstArtist;
  String? fullArtist;
  String? feats;

  // add == operator
  List<Tracklist>? tracklist;
  String? deliveryPaid;
  int? totalDuration;
  String? coverUrl;
  String? coverSquare;
  String? coverBase64;
  String? coverName;

  // add == operator
  RetailPrices? retailPrices;

  // add == operator
  List<AllContributors>? allContributors;
  String? fullTitle;
  String? releaseTiming;
  Deal? deal;
  Partners? partners;
  bool? isDelivered;

  // add == operator
  List<DeliveryCountries>? excludeCountries;

  // add == operator
  List<DeliveryCountries?>? includeCountries;

  ReleaseDetails({
    this.id,
    this.genres,
    this.dealName,
    this.idUser,
    this.idDeal,
    this.idPremiumDeal,
    this.productType,
    this.songPrice,
    this.mediaType,
    this.idSongPrice,
    this.bundlePrice,
    this.idBundlePrice,
    this.dateAdded,
    this.dateModified,
    this.dateArchived,
    this.dateRelease,
    this.datePreorder,
    this.dateStreaming,
    this.dateReleaseOriginal,
    this.dateApproved,
    this.cover,
    this.coverBase64,
    this.coverName,
    this.releaseTime,
    this.title,
    this.titleVersion,
    this.artist,
    this.displayArtist,
    this.featuring,
    this.label,
    this.eanCode,
    this.sEanCode,
    this.language,
    this.cYear,
    this.cName,
    this.pYear,
    this.pName,
    this.explicitContent,
    this.statusesArr,
    this.archived,
    this.approved,
    this.toDelete,
    this.locked,
    this.trackCount,
    this.audioBook,
    this.trendFirstSale,
    this.currency,
    this.artists,
    this.firstArtist,
    this.fullArtist,
    this.feats,
    this.tracklist,
    this.deliveryPaid,
    this.totalDuration,
    this.coverUrl,
    this.coverSquare,
    this.retailPrices,
    this.allContributors,
    this.fullTitle,
    this.releaseTiming,
    this.deal,
    this.partners,
    this.isDelivered = false,
    this.excludeCountries,
    this.includeCountries,
  });

  ReleaseDetails copyWith(
      {String? id,
      List<Genres>? genres,
      String? dealName,
      String? idUser,
      String? idDeal,
      String? idPremiumDeal,
      String? productType,
      SongPrice? songPrice,
      int? mediaType,
      String? idSongPrice,
      BundlePrice? bundlePrice,
      String? idBundlePrice,
      DateTime? dateAdded,
      String? dateModified,
      String? dateArchived,
      DateTime? dateRelease,
      DateTime? datePreorder,
      DateTime? dateStreaming,
      DateTime? dateReleaseOriginal,
      String? dateApproved,
      String? cover,
      String? releaseTime,
      String? title,
      String? titleVersion,
      List<Artists>? artist,
      String? displayArtist,
      List<Artists>? featuring,
      String? label,
      String? eanCode,
      String? sEanCode,
      String? language,
      String? cYear,
      String? cName,
      String? pYear,
      String? pName,
      String? explicitContent,
      StatusesArr? statusesArr,
      String? archived,
      String? approved,
      String? toDelete,
      String? locked,
      String? trackCount,
      String? audioBook,
      String? trendFirstSale,
      String? currency,
      String? artists,
      String? firstArtist,
      String? fullArtist,
      String? feats,
      List<Tracklist>? tracklist,
      String? deliveryPaid,
      int? totalDuration,
      String? coverUrl,
      String? coverSquare,
      String? coverBase64,
      String? coverName,
      RetailPrices? retailPrices,
      List<AllContributors>? allContributors,
      String? fullTitle,
      String? releaseTiming,
      Deal? deal,
      Partners? partners,
      List<DeliveryCountries>? excludeCountries,
      List<DeliveryCountries>? includeCountries,
      bool? isEditable,
      String? editableError,
      bool? isLocked,
      bool? isUnlockable,
      bool? isDelivered}) {
    return ReleaseDetails(
      id: this.id ?? id,
      genres: List<Genres>.from(this.genres ?? genres ?? []),
      dealName: this.dealName ?? dealName,
      idUser: this.idUser ?? idUser,
      idDeal: this.idDeal ?? idDeal,
      isDelivered: this.isDelivered ?? isDelivered,
      idPremiumDeal: this.idPremiumDeal ?? idPremiumDeal,
      productType: this.productType ?? productType,
      songPrice: this.songPrice ?? songPrice,
      idSongPrice: this.idSongPrice ?? idSongPrice,
      mediaType: this.mediaType ?? mediaType,
      bundlePrice: this.bundlePrice ?? bundlePrice,
      idBundlePrice: this.idBundlePrice ?? idBundlePrice,
      dateAdded: this.dateAdded ?? dateAdded,
      dateModified: this.dateModified ?? dateModified,
      dateArchived: this.dateArchived ?? dateArchived,
      dateRelease: this.dateRelease ?? dateRelease,
      datePreorder: this.datePreorder ?? datePreorder,
      dateStreaming: this.dateStreaming ?? dateStreaming,
      dateReleaseOriginal: this.dateReleaseOriginal ?? dateReleaseOriginal,
      dateApproved: this.dateApproved ?? dateApproved,
      cover: this.cover ?? cover,
      coverBase64: this.coverBase64 ?? coverBase64,
      coverName: this.coverName ?? coverName,
      releaseTime: this.releaseTime ?? releaseTime,
      title: this.title ?? title,
      titleVersion: this.titleVersion ?? titleVersion,
      artist: List<Artists>.from(this.artist ?? artist ?? []),
      displayArtist: this.displayArtist ?? displayArtist,
      featuring: List<Artists>.from(this.featuring ?? featuring ?? []),
      label: this.label ?? label,
      eanCode: this.eanCode ?? eanCode,
      sEanCode: this.sEanCode ?? sEanCode,
      language: this.language ?? language,
      cYear: this.cYear ?? cYear,
      cName: this.cName ?? cName,
      pYear: this.pYear ?? pYear,
      pName: this.pName ?? pName,
      explicitContent: this.explicitContent ?? explicitContent,
      statusesArr: this.statusesArr ?? statusesArr,
      archived: this.archived ?? archived,
      approved: this.approved ?? approved,
      toDelete: this.toDelete ?? toDelete,
      locked: this.locked ?? locked,
      trackCount: this.trackCount ?? trackCount,
      audioBook: this.audioBook ?? audioBook,
      trendFirstSale: this.trendFirstSale ?? trendFirstSale,
      currency: this.currency ?? currency,
      artists: this.artists ?? artists,
      firstArtist: this.firstArtist ?? firstArtist,
      fullArtist: this.fullArtist ?? fullArtist,
      feats: this.feats ?? feats,
      tracklist: (this.tracklist ?? tracklist ?? [])
          .map((Tracklist v) => v.copyWith())
          .toList(),
      deliveryPaid: this.deliveryPaid ?? deliveryPaid,
      totalDuration: this.totalDuration ?? totalDuration,
      coverUrl: this.coverUrl ?? coverUrl,
      coverSquare: this.coverSquare ?? coverSquare,
      retailPrices: this.retailPrices ?? retailPrices,
      allContributors: this.allContributors ?? allContributors,
      fullTitle: this.fullTitle ?? fullTitle,
      releaseTiming: this.releaseTiming ?? releaseTiming,
      deal: this.deal ?? deal,
      excludeCountries: (this.excludeCountries ?? excludeCountries ?? [])
          .map((v) => v.copyWith())
          .toList(),
      includeCountries: (this.includeCountries ?? includeCountries ?? [])
          .map((v) => v!.copyWith())
          .toList(),
      partners: (this.partners ?? partners ?? Partners()).copyWith(),
    );
  }

  ReleaseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    isDelivered = json['is_delivered'] ?? false;
    dealName = json['deal_name'];
    idUser = json['idUser'];
    mediaType = json['media_type'];
    idDeal = json['idDeal'];
    idPremiumDeal = json['idPremiumDeal'];
    productType = json['product_type'];
    songPrice =
        json['songPrice'] != null && json['songPrice'] is Map<String, dynamic>
            ? SongPrice.fromJson(json['songPrice'])
            : null;
    idSongPrice = json['idSongPrice'];
    bundlePrice = json['bundlePrice'] != null &&
            json['bundlePrice'] is Map<String, dynamic>
        ? BundlePrice.fromJson(json['bundlePrice'])
        : null;
    idBundlePrice = json['idBundlePrice'];
    dateAdded = json['date_added'] != null && json['date_added'] != '0'
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(json['date_added']) * 1000)
        : null;
    datePreorder = json['date_preorder'] != null && json['date_preorder'] != '0'
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(json['date_preorder']) * 1000)
        : null;
    dateStreaming =
        json['date_streaming'] != null && json['date_streaming'] != '0'
            ? DateTime.fromMillisecondsSinceEpoch(
                int.parse(json['date_streaming']) * 1000)
            : null;

    dateModified = json['date_modified'];
    dateArchived = json['date_archived'];
    dateRelease = json['date_release'] != null && json['date_release'] != '0'
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(json['date_release']) * 1000)
        : null;
    dateReleaseOriginal = json['date_release_original'] != null &&
            json['date_release_original'] != '0'
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(json['date_release_original']) * 1000)
        : null;
    dateApproved = json['date_approved'];
    cover = json['cover'];
    releaseTime = json['release_time'];
    title = json['title'];
    titleVersion = json['titleVersion'];
    artist = json['artist'] != null
        ? List<Artists>.from(
            json['artist'].map((e) => Artists(label: e, value: e)))
        : [];
    displayArtist = json['display_artist'];
    featuring = json['featuring'] != null
        ? List<Artists>.from(
            json['featuring'].map((e) => Artists(label: e, value: e)))
        : [];
    label = json['label'];
    eanCode = json['eanCode'];
    sEanCode = json['s_eanCode'];
    language = json['language'];
    cYear = json['c_year'];
    cName = json['c_name'];
    pYear = json['p_year'];
    pName = json['p_name'];
    explicitContent = json['explicitContent'];
    statusesArr = json['statusesArr'] != null
        ? StatusesArr.fromJson(json['statusesArr'])
        : null;
    archived = json['archived'];
    approved = json['approved'];
    toDelete = json['to_delete'];
    locked = json['locked'];
    trackCount = json['trackCount'];
    audioBook = json['audioBook'];
    trendFirstSale = json['trend_first_sale'];
    currency = json['currency'];
    artists = json['artists'];
    firstArtist = json['firstArtist'];
    fullArtist = json['fullArtist'];
    feats = json['feats'];
    if (json['tracklist'] != null) {
      tracklist = <Tracklist>[];
      json['tracklist'].forEach((v) {
        tracklist!.add(Tracklist.fromJson(v));
      });
    }
    deliveryPaid = json['delivery_paid'];
    totalDuration = json['total_duration'];
    coverUrl = json['cover_url'];
    coverSquare = json['cover_square'];
    retailPrices = json['retail_prices'] != null &&
            json['retail_prices'] is Map<String, dynamic>
        ? RetailPrices.fromJson(json['retail_prices'])
        : null;
    if (json['all_contributors'] != null) {
      allContributors = <AllContributors>[];
      json['all_contributors'].forEach((v) {
        allContributors!.add(AllContributors.fromJson(v));
      });
    }

    includeCountries = json['include_countries'] != null
        ? List<DeliveryCountries>.from(
            json['include_countries'].map((e) => DeliveryCountries.fromJson(e)))
        : [];

    excludeCountries = json['exclude_countries'] != null
        ? List<DeliveryCountries>.from(
            json['exclude_countries'].map((e) => DeliveryCountries.fromJson(e)))
        : [];

    fullTitle = json['fullTitle'];
    releaseTiming = json['release_timing'];
    deal = json['deal'] != null ? Deal.fromJson(json['deal']) : null;
    partners =
        json['partners'] != null ? Partners.fromJson(json['partners']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (genres != null) {
      data['genres'] = genres!.map((Genres v) => v.toJson()).toList();
    }
    data['is_delivered'] = isDelivered;
    data['media_type'] = mediaType;
    data['deal_name'] = dealName;
    data['idUser'] = idUser;
    data['idDeal'] = idDeal;
    data['idPremiumDeal'] = idPremiumDeal;
    data['product_type'] = productType;
    if (songPrice != null) {
      data['songPrice'] = songPrice!.toJson();
    }
    data['idSongPrice'] = idSongPrice;
    if (bundlePrice != null) {
      data['bundlePrice'] = bundlePrice!.toJson();
    }
    data['idBundlePrice'] = idBundlePrice;
    data['date_added'] = dateAdded != null
        ? "${dateAdded!.year}-${dateAdded!.month}-${dateAdded!.day}"
        : dateAdded;
    data['cover_base64'] = coverBase64;
    data['cover_filename'] = coverName;
    data['date_preorder'] = datePreorder != null
        ? "${datePreorder!.year}-${datePreorder!.month}-${datePreorder!.day}"
        : datePreorder;
    data['date_streaming'] = dateStreaming != null
        ? "${dateStreaming!.year}-${dateStreaming!.month}-${dateStreaming!.day}"
        : dateStreaming;
    data['date_modified'] = dateModified;
    data['date_archived'] = dateArchived;
    data['date_release'] = dateRelease != null
        ? "${dateRelease!.year}-${dateRelease!.month}-${dateRelease!.day}"
        : dateRelease;
    data['date_release_original'] = dateReleaseOriginal != null
        // ignore: lines_longer_than_80_chars
        ? "${dateReleaseOriginal!.year}-${dateReleaseOriginal!.month}-${dateReleaseOriginal!.day}"
        : dateReleaseOriginal;
    data['date_approved'] = dateApproved;
    data['cover'] = cover;
    data['release_time'] = releaseTime;
    data['title'] = title;
    data['titleVersion'] = titleVersion;
    if (artist != null) {
      data['artist'] = artist!.map((Artists v) => [v.value]).toList();
    }
    data['display_artist'] = displayArtist;
    if (featuring != null) {
      data['featuring'] = featuring!.map((Artists v) => [v.value]).toList();
    }
    data['label'] = label;
    data['eanCode'] = eanCode;
    data['s_eanCode'] = sEanCode;
    data['language'] = language;
    data['c_year'] = cYear;
    data['c_name'] = cName;
    data['p_year'] = pYear;
    data['p_name'] = pName;
    data['explicitContent'] = explicitContent;
    if (statusesArr != null) {
      data['statusesArr'] = statusesArr!.toJson();
    }
    data['archived'] = archived;
    data['approved'] = approved;
    data['to_delete'] = toDelete;
    data['locked'] = locked;
    data['trackCount'] = trackCount;
    data['audioBook'] = audioBook;
    data['trend_first_sale'] = trendFirstSale;
    data['currency'] = currency;
    data['artists'] = artists;
    data['firstArtist'] = firstArtist;
    data['fullArtist'] = fullArtist;
    data['feats'] = feats;
    if (tracklist != null) {
      data['tracklist'] = tracklist!.map((Tracklist v) => v.toJson()).toList();
    }
    data['delivery_paid'] = deliveryPaid;
    data['total_duration'] = totalDuration;
    data['cover_url'] = coverUrl;
    data['cover_square'] = coverSquare;
    if (retailPrices != null) {
      data['retail_prices'] = retailPrices!.toJson();
    }
    if (allContributors != null) {
      data['all_contributors'] =
          allContributors!.map((AllContributors v) => v.toJson()).toList();
    }
    data['fullTitle'] = fullTitle;
    data['release_timing'] = releaseTiming;
    if (deal != null) {
      data['deal'] = deal!.toJson();
    }
    if (partners != null) {
      data['partners'] = partners!.toJson();
    }
    if (includeCountries != null) {
      data['include_countries'] =
          includeCountries!.map((DeliveryCountries? v) => v!.toJson()).toList();
    }
    if (excludeCountries != null) {
      data['exclude_countries'] =
          excludeCountries!.map((DeliveryCountries v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    Function deepEq = const DeepCollectionEquality.unordered().equals;

    return identical(this, other) ||
        other is ReleaseDetails &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            deepEq(genres, other.genres) &&
            dealName == other.dealName &&
            mediaType == other.mediaType &&
            idUser == other.idUser &&
            idDeal == other.idDeal &&
            idPremiumDeal == other.idPremiumDeal &&
            productType == other.productType &&
            songPrice == other.songPrice &&
            idSongPrice == other.idSongPrice &&
            bundlePrice == other.bundlePrice &&
            idBundlePrice == other.idBundlePrice &&
            dateAdded == other.dateAdded &&
            dateModified == other.dateModified &&
            dateArchived == other.dateArchived &&
            dateRelease == other.dateRelease &&
            datePreorder == other.datePreorder &&
            dateStreaming == other.dateStreaming &&
            dateReleaseOriginal == other.dateReleaseOriginal &&
            dateApproved == other.dateApproved &&
            cover == other.cover &&
            releaseTime == other.releaseTime &&
            title == other.title &&
            titleVersion == other.titleVersion &&
            deepEq(artist, other.artist) &&
            displayArtist == other.displayArtist &&
            deepEq(featuring, other.featuring) &&
            label == other.label &&
            eanCode == other.eanCode &&
            sEanCode == other.sEanCode &&
            language == other.language &&
            cYear == other.cYear &&
            cName == other.cName &&
            pYear == other.pYear &&
            pName == other.pName &&
            explicitContent == other.explicitContent &&
            statusesArr == other.statusesArr &&
            archived == other.archived &&
            approved == other.approved &&
            toDelete == other.toDelete &&
            locked == other.locked &&
            trackCount == other.trackCount &&
            audioBook == other.audioBook &&
            trendFirstSale == other.trendFirstSale &&
            currency == other.currency &&
            artists == other.artists &&
            firstArtist == other.firstArtist &&
            fullArtist == other.fullArtist &&
            feats == other.feats &&
            deepEq(tracklist, other.tracklist) &&
            deliveryPaid == other.deliveryPaid &&
            totalDuration == other.totalDuration &&
            coverUrl == other.coverUrl &&
            coverSquare == other.coverSquare &&
            coverBase64 == other.coverBase64 &&
            coverName == other.coverName &&
            retailPrices == other.retailPrices &&
            deepEq(allContributors, other.allContributors) &&
            fullTitle == other.fullTitle &&
            releaseTiming == other.releaseTiming &&
            deal == other.deal &&
            deepEq(partners, other.partners) &&
            deepEq(excludeCountries, other.excludeCountries) &&
            deepEq(includeCountries, other.includeCountries);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      genres.hashCode ^
      dealName.hashCode ^
      idUser.hashCode ^
      idDeal.hashCode ^
      mediaType.hashCode ^
      idPremiumDeal.hashCode ^
      productType.hashCode ^
      songPrice.hashCode ^
      idSongPrice.hashCode ^
      bundlePrice.hashCode ^
      idBundlePrice.hashCode ^
      dateAdded.hashCode ^
      dateModified.hashCode ^
      dateArchived.hashCode ^
      dateRelease.hashCode ^
      datePreorder.hashCode ^
      dateStreaming.hashCode ^
      dateReleaseOriginal.hashCode ^
      dateApproved.hashCode ^
      cover.hashCode ^
      releaseTime.hashCode ^
      title.hashCode ^
      titleVersion.hashCode ^
      artist.hashCode ^
      displayArtist.hashCode ^
      featuring.hashCode ^
      label.hashCode ^
      eanCode.hashCode ^
      sEanCode.hashCode ^
      language.hashCode ^
      cYear.hashCode ^
      cName.hashCode ^
      pYear.hashCode ^
      pName.hashCode ^
      explicitContent.hashCode ^
      statusesArr.hashCode ^
      archived.hashCode ^
      approved.hashCode ^
      toDelete.hashCode ^
      locked.hashCode ^
      trackCount.hashCode ^
      audioBook.hashCode ^
      trendFirstSale.hashCode ^
      currency.hashCode ^
      artists.hashCode ^
      firstArtist.hashCode ^
      fullArtist.hashCode ^
      feats.hashCode ^
      tracklist.hashCode ^
      deliveryPaid.hashCode ^
      totalDuration.hashCode ^
      coverUrl.hashCode ^
      coverSquare.hashCode ^
      coverBase64.hashCode ^
      coverName.hashCode ^
      retailPrices.hashCode ^
      allContributors.hashCode ^
      fullTitle.hashCode ^
      releaseTiming.hashCode ^
      deal.hashCode ^
      partners.hashCode ^
      excludeCountries.hashCode ^
      includeCountries.hashCode;
}

class Genres {
  String? id;
  String? idRelease;
  String? idGenre;
  String? name;
  String? itunesPrimary;
  String? itunesSecondary;
  String? classical;
  String? isAudioBook;

  Genres({
    this.id,
    this.idRelease,
    this.idGenre,
    this.name,
    this.itunesPrimary,
    this.itunesSecondary,
    this.classical,
    this.isAudioBook,
  });

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRelease = json['idRelease'];
    idGenre = json['idGenre'];
    name = json['name'];
    itunesPrimary = json['itunes_primary'];
    itunesSecondary = json['itunes_secondary'];
    classical = json['classical'];
    isAudioBook = json['is_audio_book'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    // data['idRelease'] = idRelease;
    data['idGenre'] = idGenre;
    // data['name'] = name;
    // data['itunes_primary'] = itunesPrimary;
    // data['itunes_secondary'] = itunesSecondary;
    // data['classical'] = classical;
    // data['is_audio_book'] = isAudioBook;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Genres &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          idRelease == other.idRelease &&
          idGenre == other.idGenre &&
          name == other.name;

  @override
  int get hashCode =>
      id.hashCode ^ idRelease.hashCode ^ idGenre.hashCode ^ name.hashCode;

  @override
  String toString() {
    return "Genres{id: $id, idRelease: $idRelease, idGenre: $idGenre,"
        " name: $name, itunesPrimary: $itunesPrimary,"
        " itunesSecondary: $itunesSecondary, classical: $classical,"
        " isAudioBook: $isAudioBook}";
  }
}

class SongPrice {
  int? id;
  String? currency;
  double? price;

  SongPrice({this.id, this.currency, this.price});

  SongPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    price = double.tryParse(json['price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currency'] = currency;
    data['price'] = price;
    return data;
  }
}

class BundlePrice {
  int? id;
  String? currency;
  double? price;

  BundlePrice({this.id, this.currency, this.price});

  BundlePrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    price = double.tryParse("${json['price']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currency'] = currency;
    data['price'] = price;
    return data;
  }
}

class StatusesArr {
  String? completed1;
  String? completed11;
  String? completed12;
  String? completed13;
  String? completed14;
  String? completed2;
  String? completed3;
  String? completed4;
  String? completed5;

  StatusesArr(
      {this.completed1,
      this.completed11,
      this.completed12,
      this.completed13,
      this.completed14,
      this.completed2,
      this.completed3,
      this.completed4,
      this.completed5});

  StatusesArr.fromJson(Map<String, dynamic> json) {
    completed1 = json['completed1'].toString();
    completed11 = json['completed1_1'].toString();
    completed12 = json['completed1_2'].toString();
    completed13 = json['completed1_3'].toString();
    completed14 = json['completed1_4'].toString();
    completed2 = json['completed2'].toString();
    completed3 = json['completed3'].toString();
    completed4 = json['completed4'].toString();
    completed5 = json['completed5'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed1'] = completed1;
    data['completed1_1'] = completed11;
    data['completed1_2'] = completed12;
    data['completed1_3'] = completed13;
    data['completed1_4'] = completed14;
    data['completed2'] = completed2;
    data['completed3'] = completed3;
    data['completed4'] = completed4;
    data['completed5'] = completed5;
    return data;
  }
}

class Tracklist {
  String? id;
  String? idRelease;
  String? audioFilename;
  String? audioWav;
  String? audioMp3;
  String? duration;
  String? sampleStart;
  String? sampleDuration;
  String? title;
  List<Artists>? artist;
  String? displayArtist;
  List<Artists>? featuring;
  List<Artists>? composer;
  List<Artists>? lyrist;
  String? version;
  String? isrc;
  String? sIsrc;
  String? publisher;
  String? pYear;
  String? pName;
  String? recordingType;
  String? disc;
  String? trackNumber;
  String? completed;
  String? explicit;
  String? explicitContentEdited;
  String? lyrics;
  String? firstArtist;
  String? artists;
  String? feats;
  String? fullArtist;
  String? fullComposer;
  String? fullLyrist;
  String? sampleStartString;
  File? trackFile;
  String? trackPath;
  List<AdditionalContributors>? additionalContributors;
  List<Contributors>? contributors;

  Tracklist({
    this.id,
    this.idRelease,
    this.audioFilename,
    this.audioWav,
    this.audioMp3,
    this.duration,
    this.sampleStart,
    this.sampleDuration,
    this.title,
    this.artist,
    this.displayArtist,
    this.featuring,
    this.composer,
    this.lyrist,
    this.version,
    this.isrc,
    this.sIsrc,
    this.publisher,
    this.pYear,
    this.pName,
    this.recordingType,
    this.disc,
    this.trackNumber,
    this.completed,
    this.explicit,
    this.explicitContentEdited,
    this.lyrics,
    this.firstArtist,
    this.artists,
    this.feats,
    this.fullArtist,
    this.fullComposer,
    this.fullLyrist,
    this.trackFile,
    this.sampleStartString,
    this.additionalContributors,
    this.contributors,
    this.trackPath,
  });

  Tracklist copyWith({
    String? id,
    String? idRelease,
    String? audioFilename,
    String? audioWav,
    String? audioMp3,
    String? duration,
    String? sampleStart,
    String? sampleDuration,
    String? title,
    List<Artists>? artist,
    String? displayArtist,
    List<Artists>? featuring,
    List<Artists>? composer,
    List<Artists>? lyrist,
    String? version,
    String? isrc,
    String? sIsrc,
    String? publisher,
    String? pYear,
    String? pName,
    String? recordingType,
    String? disc,
    String? trackNumber,
    String? completed,
    String? explicit,
    String? explicitContentEdited,
    String? lyrics,
    String? firstArtist,
    String? artists,
    String? feats,
    String? fullArtist,
    String? fullComposer,
    String? fullLyrist,
    String? sampleStartString,
    File? trackFile,
    String? trackPath,
    List<AdditionalContributors>? additionalContributors,
    List<Contributors>? contributors,
  }) {
    return Tracklist(
      id: id ?? this.id,
      idRelease: idRelease ?? this.idRelease,
      audioFilename: audioFilename ?? this.audioFilename,
      audioWav: audioWav ?? this.audioWav,
      audioMp3: audioMp3 ?? this.audioMp3,
      duration: duration ?? this.duration,
      sampleStart: sampleStart ?? this.sampleStart,
      sampleDuration: sampleDuration ?? this.sampleDuration,
      title: title ?? this.title,
      artist: artist ?? this.artist ?? [],
      displayArtist: displayArtist ?? this.displayArtist,
      featuring: featuring ?? this.featuring ?? [],
      composer: composer ?? this.composer ?? [],
      lyrist: lyrist ?? this.lyrist ?? [],
      version: version ?? this.version,
      isrc: isrc ?? this.isrc,
      sIsrc: sIsrc ?? this.sIsrc,
      publisher: publisher ?? this.publisher,
      pYear: pYear ?? this.pYear,
      pName: pName ?? this.pName,
      recordingType: recordingType ?? this.recordingType,
      disc: disc ?? this.disc,
      trackNumber: trackNumber ?? this.trackNumber,
      completed: completed ?? this.completed,
      explicit: explicit ?? this.explicit,
      explicitContentEdited:
          explicitContentEdited ?? this.explicitContentEdited,
      lyrics: lyrics ?? this.lyrics,
      firstArtist: firstArtist ?? this.firstArtist,
      artists: artists ?? this.artists,
      feats: feats ?? this.feats,
      fullArtist: fullArtist ?? this.fullArtist,
      fullComposer: fullComposer ?? this.fullComposer,
      fullLyrist: fullLyrist ?? this.fullLyrist,
      sampleStartString: sampleStartString ?? this.sampleStartString,
      trackPath: trackPath ?? this.trackPath,
      trackFile: trackFile ?? this.trackFile,
      additionalContributors:
          additionalContributors ?? this.additionalContributors ?? [],
      contributors: contributors ?? this.contributors ?? [],
    );
  }

  Tracklist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRelease = json['idRelease'];
    audioFilename = json['audioFilename'];
    audioWav = json['audioWav'];
    audioMp3 = json['audioMp3'];
    duration = json['duration'];
    sampleStart = json['sampleStart'];
    sampleDuration = json['sampleDuration'];
    title = json['title'];
    artist = List<Artists>.from(
        (json['artist'] ?? []).map((v) => Artists(label: v, value: v)));
    featuring = List<Artists>.from(
        (json['featuring'] ?? []).map((v) => Artists(label: v, value: v)));
    composer = List<Artists>.from(
        (json['composer'] ?? []).map((v) => Artists(label: v, value: v)));
    lyrist = List<Artists>.from(
        (json['lyrist'] ?? []).map((v) => Artists(label: v, value: v)));
    displayArtist = json['display_artist'];
    version = json['version'];
    isrc = json['isrc'];
    sIsrc = json['s_isrc'];
    publisher = json['publisher'];
    pYear = json['p_year'];
    pName = json['p_name'];
    recordingType = json['recordingType'];
    disc = json['disc'];
    trackNumber = json['trackNumber'];
    completed = json['completed'];
    explicit = json['explicit'];
    explicitContentEdited = json['explicit_content_edited'];
    lyrics = json['lyrics'];
    firstArtist = "${json['firstArtist']}";
    artists = json['artists'];
    feats = json['feats'];
    fullArtist = json['fullArtist'];
    fullComposer = json['fullComposer'];
    fullLyrist = json['fullLyrist'];
    sampleStartString = json['sampleStartString'];
    contributors = List<Contributors>.from(
        (json['contributors'] ?? []).map((v) => Contributors.fromJson(v)));
    additionalContributors = List<AdditionalContributors>.from(
        (json['additional_contributors'] ?? [])
            .map((v) => AdditionalContributors.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idRelease'] = idRelease;
    data['audioFilename'] = audioFilename;
    data['audioWav'] = audioWav;
    data['audioMp3'] = audioMp3;
    data['duration'] = duration;
    data['sampleStart'] = sampleStart;
    data['sampleDuration'] = sampleDuration;
    data['title'] = title;
    data['artist'] = (artist ?? []).map((Artists v) => [v.value]).toList();
    data['display_artist'] = displayArtist;
    data['featuring'] =
        (featuring ?? []).map((Artists v) => [v.value]).toList();
    data['composer'] = (composer ?? []).map((Artists v) => [v.value]).toList();
    data['lyrist'] = (lyrist ?? []).map((Artists v) => [v.value]).toList();
    data['version'] = version;
    data['isrc'] = isrc;
    data['s_isrc'] = sIsrc;
    data['publisher'] = publisher;
    data['p_year'] = pYear;
    data['p_name'] = pName;
    data['recordingType'] = recordingType;
    data['disc'] = disc;
    data['trackNumber'] = trackNumber;
    data['completed'] = completed;
    data['explicit'] = explicit;
    data['explicit_content_edited'] = explicitContentEdited;
    data['lyrics'] = lyrics;
    data['firstArtist'] = firstArtist;
    data['artists'] = artists;
    data['feats'] = feats;
    data['fullArtist'] = fullArtist;
    data['fullComposer'] = fullComposer;
    data['fullLyrist'] = fullLyrist;
    data['sampleStartString'] = sampleStartString;
    data['audio_file'] = trackFile;
    data['dropbox_file_url'] = trackPath;
    data['dropbox_file_name'] = audioFilename;
    data['contributors'] =
        (contributors ?? []).map((Contributors v) => v.name).toList();
    data['additional_contributors'] = (additionalContributors ?? [])
        .map((AdditionalContributors v) => v.toJson())
        .toList();
    return data;
  }

  @override
  bool operator ==(Object other) {
    Function deepEq = const DeepCollectionEquality.unordered().equals;
    return identical(this, other) ||
        other is Tracklist &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            idRelease == other.idRelease &&
            audioFilename == other.audioFilename &&
            audioWav == other.audioWav &&
            audioMp3 == other.audioMp3 &&
            duration == other.duration &&
            sampleStart == other.sampleStart &&
            sampleDuration == other.sampleDuration &&
            title == other.title &&
            deepEq(artist, other.artist) &&
            displayArtist == other.displayArtist &&
            deepEq(featuring, other.featuring) &&
            deepEq(composer, other.composer) &&
            deepEq(lyrist, other.lyrist) &&
            version == other.version &&
            isrc == other.isrc &&
            sIsrc == other.sIsrc &&
            publisher == other.publisher &&
            pYear == other.pYear &&
            pName == other.pName &&
            recordingType == other.recordingType &&
            disc == other.disc &&
            trackNumber == other.trackNumber &&
            completed == other.completed &&
            explicit == other.explicit &&
            explicitContentEdited == other.explicitContentEdited &&
            lyrics == other.lyrics &&
            firstArtist == other.firstArtist &&
            artists == other.artists &&
            feats == other.feats &&
            fullArtist == other.fullArtist &&
            fullComposer == other.fullComposer &&
            fullLyrist == other.fullLyrist &&
            sampleStartString == other.sampleStartString &&
            trackPath == other.trackPath &&
            deepEq(additionalContributors, other.additionalContributors) &&
            deepEq(contributors, other.contributors);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      idRelease.hashCode ^
      audioFilename.hashCode ^
      audioWav.hashCode ^
      audioMp3.hashCode ^
      duration.hashCode ^
      sampleStart.hashCode ^
      sampleDuration.hashCode ^
      title.hashCode ^
      artist.hashCode ^
      displayArtist.hashCode ^
      featuring.hashCode ^
      composer.hashCode ^
      lyrist.hashCode ^
      version.hashCode ^
      isrc.hashCode ^
      sIsrc.hashCode ^
      publisher.hashCode ^
      pYear.hashCode ^
      pName.hashCode ^
      recordingType.hashCode ^
      disc.hashCode ^
      trackNumber.hashCode ^
      completed.hashCode ^
      explicit.hashCode ^
      explicitContentEdited.hashCode ^
      lyrics.hashCode ^
      firstArtist.hashCode ^
      artists.hashCode ^
      feats.hashCode ^
      fullArtist.hashCode ^
      fullComposer.hashCode ^
      fullLyrist.hashCode ^
      sampleStartString.hashCode ^
      trackPath.hashCode ^
      additionalContributors.hashCode ^
      contributors.hashCode;
}

class AllContributors {
  String? id;
  String? artistName;
  String? name;
  String? idRelation;
  String? type;
  String? itunesId;
  String? spotifyId;
  String? role;
  String? roleSlug;
  String? itunesRole;
  int? primaryRole;

  AllContributors(
      {this.id,
      this.artistName,
      this.name,
      this.idRelation,
      this.type,
      this.itunesId,
      this.spotifyId,
      this.role,
      this.roleSlug,
      this.itunesRole,
      this.primaryRole});

  AllContributors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artistName = json['artistName'];
    name = json['name'];
    idRelation = json['idRelation'];
    type = json['type'];
    itunesId = json['itunes_id'];
    spotifyId = json['spotify_id'];
    role = json['role'];
    roleSlug = json['role_slug'];
    itunesRole = json['itunes_role'];
    primaryRole = json['primary_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['artistName'] = artistName;
    data['name'] = name;
    data['idRelation'] = idRelation;
    data['type'] = type;
    data['itunes_id'] = itunesId;
    data['spotify_id'] = spotifyId;
    data['role'] = role;
    data['role_slug'] = roleSlug;
    data['itunes_role'] = itunesRole;
    data['primary_role'] = primaryRole;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllContributors &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          artistName == other.artistName &&
          name == other.name &&
          idRelation == other.idRelation &&
          type == other.type &&
          itunesId == other.itunesId &&
          spotifyId == other.spotifyId &&
          role == other.role &&
          roleSlug == other.roleSlug &&
          itunesRole == other.itunesRole &&
          primaryRole == other.primaryRole;

  @override
  int get hashCode =>
      id.hashCode ^
      artistName.hashCode ^
      name.hashCode ^
      artistName.hashCode ^
      idRelation.hashCode ^
      type.hashCode ^
      itunesId.hashCode ^
      spotifyId.hashCode ^
      role.hashCode ^
      roleSlug.hashCode ^
      itunesRole.hashCode ^
      primaryRole.hashCode;
}

class Contributors {
  String? id;
  String? artistName;
  String? name;
  String? idRelation;
  String? type;
  String? itunesId;
  String? spotifyId;
  String? role;
  String? roleSlug;
  String? itunesRole;
  int? primaryRole;

  Contributors(
      {this.id,
      this.artistName,
      this.name,
      this.idRelation,
      this.type,
      this.itunesId,
      this.spotifyId,
      this.role,
      this.roleSlug,
      this.itunesRole,
      this.primaryRole});

  Contributors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artistName = json['artistName'];
    name = json['name'];
    idRelation = json['idRelation'];
    type = json['type'];
    itunesId = json['itunes_id'];
    spotifyId = json['spotify_id'];
    role = json['role'];
    roleSlug = json['role_slug'];
    itunesRole = json['itunes_role'];
    primaryRole = json['primary_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['artistName'] = artistName;
    data['name'] = name;
    data['idRelation'] = idRelation;
    data['type'] = type;
    data['itunes_id'] = itunesId;
    data['spotify_id'] = spotifyId;
    data['role'] = role;
    data['role_slug'] = roleSlug;
    data['itunes_role'] = itunesRole;
    data['primary_role'] = primaryRole;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contributors &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          artistName == other.artistName &&
          name == other.name &&
          idRelation == other.idRelation &&
          type == other.type &&
          itunesId == other.itunesId &&
          spotifyId == other.spotifyId &&
          role == other.role &&
          roleSlug == other.roleSlug &&
          itunesRole == other.itunesRole &&
          primaryRole == other.primaryRole;

  @override
  int get hashCode =>
      id.hashCode ^
      artistName.hashCode ^
      name.hashCode ^
      artistName.hashCode ^
      idRelation.hashCode ^
      type.hashCode ^
      itunesId.hashCode ^
      spotifyId.hashCode ^
      role.hashCode ^
      roleSlug.hashCode ^
      itunesRole.hashCode ^
      primaryRole.hashCode;
}

class AdditionalContributors {
  String? id;
  String? artistName;
  String? name;
  String? idRelation;
  String? type;
  String? itunesId;
  String? spotifyId;
  String? role;
  String? roleSlug;
  int? primaryRole;

  AdditionalContributors(
      {this.id,
      this.artistName,
      this.name,
      this.idRelation,
      this.type,
      this.itunesId,
      this.spotifyId,
      this.role,
      this.roleSlug,
      this.primaryRole});

  AdditionalContributors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artistName = json['artistName'];
    name = json['name'];
    idRelation = json['idRelation'];
    type = json['type'];
    itunesId = json['itunes_id'];
    spotifyId = json['spotify_id'];
    role = json['role'];
    roleSlug = json['role_slug'];
    primaryRole = json['primary_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['artistName'] = artistName;
    data['name'] = name;
    data['idRelation'] = idRelation;
    data['type'] = type;
    data['itunes_id'] = itunesId;
    data['spotify_id'] = spotifyId;
    data['role'] = role;
    data['role_slug'] = roleSlug;
    data['primary_role'] = primaryRole;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditionalContributors &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          artistName == other.artistName &&
          name == other.name &&
          idRelation == other.idRelation &&
          type == other.type &&
          itunesId == other.itunesId &&
          spotifyId == other.spotifyId &&
          role == other.role &&
          roleSlug == other.roleSlug &&
          primaryRole == other.primaryRole;

  @override
  int get hashCode =>
      id.hashCode ^
      artistName.hashCode ^
      name.hashCode ^
      artistName.hashCode ^
      idRelation.hashCode ^
      type.hashCode ^
      itunesId.hashCode ^
      spotifyId.hashCode ^
      role.hashCode ^
      roleSlug.hashCode ^
      primaryRole.hashCode;
}

class RetailPrices {
  EUR? eUR;
  EUR? cHF;
  EUR? gBP;
  EUR? uSD;

  RetailPrices({this.eUR, this.cHF, this.gBP, this.uSD});

  RetailPrices.fromJson(Map<String, dynamic> json) {
    eUR = json['EUR'] != null ? EUR.fromJson(json['EUR']) : null;
    cHF = json['CHF'] != null ? EUR.fromJson(json['CHF']) : null;
    gBP = json['GBP'] != null ? EUR.fromJson(json['GBP']) : null;
    uSD = json['USD'] != null ? EUR.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eUR != null) {
      data['EUR'] = eUR!.toJson();
    }
    if (cHF != null) {
      data['CHF'] = cHF!.toJson();
    }
    if (gBP != null) {
      data['GBP'] = gBP!.toJson();
    }
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    return data;
  }
}

class EUR {
  String? bundle;
  String? song;

  EUR({this.bundle, this.song});

  EUR.fromJson(Map<String, dynamic> json) {
    bundle = json['bundle'];
    song = json['song'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bundle'] = bundle;
    data['song'] = song;
    return data;
  }
}

class Deal {
  String? id;
  String? name;
  String? displayName;

  Deal({this.id, this.name, this.displayName});

  Deal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['display_name'] = displayName;
    return data;
  }
}

class Partners {
  List<String>? live;
  List<Full>? full;

  Partners({this.live, this.full});

  Partners.fromJson(Map<String, dynamic> json) {
    live = json['live'].cast<String>();
    if (json['full'] != null) {
      full = <Full>[];
      json['full'].forEach((v) {
        full!.add(Full.fromJson(v));
      });
    }
  }

  Partners copyWith({
    List<String>? live,
    List<Full>? full,
  }) {
    return Partners(
      live: this.live ?? live,
      full: List<Full>.from(this.full ?? full ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['live'] = live;
    if (full != null) {
      data['full'] = full!.map((Full v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    Function deepEq = const DeepCollectionEquality.unordered().equals;

    return identical(this, other) ||
        other is Partners &&
            runtimeType == other.runtimeType &&
            live == other.live &&
            deepEq(full, other.full);
  }

  @override
  int get hashCode => live.hashCode ^ full.hashCode;
}

class Full {
  String? idPartner;
  String? code;
  String? name;

  Full({this.idPartner, this.code, this.name});

  Full.fromJson(Map<String, dynamic> json) {
    idPartner = json['idPartner'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPartner'] = idPartner;
    data['code'] = code;
    data['name'] = name;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Full &&
            runtimeType == other.runtimeType &&
            idPartner == other.idPartner &&
            code == other.code &&
            name == other.name;
  }

  @override
  int get hashCode => idPartner.hashCode ^ code.hashCode ^ name.hashCode;
}
