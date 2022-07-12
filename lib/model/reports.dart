class Reports {
  int? status;
  Years? years;
  List<Releases>? releases;
  List<Stores>? stores;
  Totals? totals;

  Reports({this.status, this.years, this.releases, this.stores, this.totals});

  Reports.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    years = json['years'] != null ? Years.fromJson(json['years']) : null;
    if (json['releases'] != null) {
      releases = <Releases>[];
      json['releases'].forEach((v) {
        releases!.add(Releases.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (years != null) {
      data['years'] = years!.toJson();
    }
    if (releases != null) {
      data['releases'] = releases!.map((Releases v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((Stores v) => v.toJson()).toList();
    }
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    return data;
  }
}

class Years {
  List<String>? l2013;
  List<String>? l2014;
  List<String>? l2015;
  List<String>? l2016;
  List<String>? l2017;
  List<String>? l2018;
  List<String>? l2019;

  Years(
      {this.l2013,
      this.l2014,
      this.l2015,
      this.l2016,
      this.l2017,
      this.l2018,
      this.l2019});

  Years.fromJson(Map<String, dynamic> json) {
    l2013 = json['2013'].cast<String>();
    l2014 = json['2014'].cast<String>();
    l2015 = json['2015'].cast<String>();
    l2016 = json['2016'].cast<String>();
    l2017 = json['2017'].cast<String>();
    l2018 = json['2018'].cast<String>();
    l2019 = json['2019'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['2013'] = l2013;
    data['2014'] = l2014;
    data['2015'] = l2015;
    data['2016'] = l2016;
    data['2017'] = l2017;
    data['2018'] = l2018;
    data['2019'] = l2019;
    return data;
  }
}

class Releases {
  String? id;
  String? idUser;
  String? idRecordjetGenre;
  String? idServiceProvider;
  String? idExternal;
  String? idDeal;
  String? idPremiumDeal;
  String? productType;
  String? idProduct;
  String? songPrice;
  String? idSongPrice;
  String? bundlePrice;
  String? idBundlePrice;
  String? mediaType;
  String? dateAdded;
  String? dateModified;
  String? dateArchived;
  String? dateFirst;
  String? dateRelease;
  String? dateReleaseOriginal;
  String? dateReleaseTime;
  String? dateSaleStart;
  String? dateSaleEnd;
  String? dateApproved;
  String? dateReminded;
  String? dateDelivered;
  String? datePreorder;
  String? dateStreaming;
  String? dateLastCloudUpload;
  String? dateLastEncoded;
  String? cover;
  String? coverExternal;
  String? audioExternal;
  String? title;
  String? titleVersion;
  List<String>? artist;
  String? displayArtist;
  List<dynamic>? featuring;
  String? label;
  String? eanCode;
  String? articleNr;
  String? articleNr2;
  String? language;
  String? cYear;
  String? cName;
  String? pYear;
  String? pName;
  String? hideSnippets;
  String? bundleOnly;
  String? freeStreaming;
  String? explicitContent;
  String? junoGenre;
  String? youtubeGenre;
  String? youtubePolicy;
  String? phononetGenre;
  String? phononetWholesale;
  String? phononetRetail;
  String? phononetType;
  String? externalGenre;
  String? amazonPriceUS;
  String? amazonPriceEU;
  String? kontorPrimaryGenre;
  String? kontorSecondaryGenre;
  String? detailsInvoice;
  String? detailsDelivery;
  String? agree;
  String? approved;
  String? deliveryInProgress;
  String? isTemp;
  String? imported;
  String? completed1;
  String? completed2;
  String? completed3;
  String? completed4;
  String? completed5;
  String? toDelete;
  String? promo;
  String? onCloud;
  String? cloudUploadFailed;
  String? archived;
  String? physical;
  String? trackCount;
  String? googleDeliveryType;
  String? listenBeforeRelease;
  String? audioBook;
  String? restrictCountry;
  String? readyForDelivery;
  String? emailContact;
  String? releaseNote;
  String? locked;
  String? bookCopyright;
  String? bookDescription;
  String? userUnlocked;
  String? smsMerchandise;
  String? freeDownload;
  String? salesCount;
  String? cloudInProgress;
  String? reportingPriority;
  double? royalty;
  String? shop;
  String? suisa;
  String? vat;
  String? trans;
  String? total;
  String? streams;
  String? downloads;
  String? physicalFeesPicking;
  String? physicalReservePublishing;
  String? physicalReserveRefund;
  String? vatPercent;
  String? type;
  String? rows;
  String? fullArtist;
  String? fullTitle;
  String? currency;
  double? fRoyalty;

  Releases(
      {this.id,
      this.idUser,
      this.idRecordjetGenre,
      this.idServiceProvider,
      this.idExternal,
      this.idDeal,
      this.idPremiumDeal,
      this.productType,
      this.idProduct,
      this.songPrice,
      this.idSongPrice,
      this.bundlePrice,
      this.idBundlePrice,
      this.mediaType,
      this.dateAdded,
      this.dateModified,
      this.dateArchived,
      this.dateFirst,
      this.dateRelease,
      this.dateReleaseOriginal,
      this.dateReleaseTime,
      this.dateSaleStart,
      this.dateSaleEnd,
      this.dateApproved,
      this.dateReminded,
      this.dateDelivered,
      this.datePreorder,
      this.dateStreaming,
      this.dateLastCloudUpload,
      this.dateLastEncoded,
      this.cover,
      this.coverExternal,
      this.audioExternal,
      this.title,
      this.titleVersion,
      this.artist,
      this.displayArtist,
      this.featuring,
      this.label,
      this.eanCode,
      this.articleNr,
      this.articleNr2,
      this.language,
      this.cYear,
      this.cName,
      this.pYear,
      this.pName,
      this.hideSnippets,
      this.bundleOnly,
      this.freeStreaming,
      this.explicitContent,
      this.junoGenre,
      this.youtubeGenre,
      this.youtubePolicy,
      this.phononetGenre,
      this.phononetWholesale,
      this.phononetRetail,
      this.phononetType,
      this.externalGenre,
      this.amazonPriceUS,
      this.amazonPriceEU,
      this.kontorPrimaryGenre,
      this.kontorSecondaryGenre,
      this.detailsInvoice,
      this.detailsDelivery,
      this.agree,
      this.approved,
      this.deliveryInProgress,
      this.isTemp,
      this.imported,
      this.completed1,
      this.completed2,
      this.completed3,
      this.completed4,
      this.completed5,
      this.toDelete,
      this.promo,
      this.onCloud,
      this.cloudUploadFailed,
      this.archived,
      this.physical,
      this.trackCount,
      this.googleDeliveryType,
      this.listenBeforeRelease,
      this.audioBook,
      this.restrictCountry,
      this.readyForDelivery,
      this.emailContact,
      this.releaseNote,
      this.locked,
      this.bookCopyright,
      this.bookDescription,
      this.userUnlocked,
      this.smsMerchandise,
      this.freeDownload,
      this.salesCount,
      this.cloudInProgress,
      this.reportingPriority,
      this.royalty,
      this.shop,
      this.suisa,
      this.vat,
      this.trans,
      this.total,
      this.streams,
      this.downloads,
      this.physicalFeesPicking,
      this.physicalReservePublishing,
      this.physicalReserveRefund,
      this.vatPercent,
      this.type,
      this.rows,
      this.fullArtist,
      this.fullTitle,
      this.currency,
      this.fRoyalty});

  Releases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    idRecordjetGenre = json['idRecordjetGenre'];
    idServiceProvider = json['idServiceProvider'];
    idExternal = json['idExternal'];
    idDeal = json['idDeal'];
    idPremiumDeal = json['idPremiumDeal'];
    productType = json['product_type'];
    idProduct = json['idProduct'];
    songPrice = json['songPrice'];
    idSongPrice = json['idSongPrice'];
    bundlePrice = json['bundlePrice'];
    idBundlePrice = json['idBundlePrice'];
    mediaType = json['mediaType'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    dateArchived = json['date_archived'];
    dateFirst = json['date_first'];
    dateRelease = json['date_release'];
    dateReleaseOriginal = json['date_release_original'];
    dateReleaseTime = json['date_release_time'];
    dateSaleStart = json['date_sale_start'];
    dateSaleEnd = json['date_sale_end'];
    dateApproved = json['date_approved'];
    dateReminded = json['date_reminded'];
    dateDelivered = json['date_delivered'];
    datePreorder = json['date_preorder'];
    dateStreaming = json['date_streaming'];
    dateLastCloudUpload = json['date_last_cloud_upload'];
    dateLastEncoded = json['date_last_encoded'];
    cover = json['cover'];
    coverExternal = json['cover_external'];
    audioExternal = json['audioExternal'];
    title = json['title'];
    titleVersion = json['titleVersion'];
    artist = json['artist'].cast<String>();
    displayArtist = json['display_artist'];
    if (json['featuring'] != null) {
      featuring = <dynamic>[];
      json['featuring'].forEach((v) {
        featuring!.add((v));
      });
    }
    label = json['label'];
    eanCode = json['eanCode'];
    articleNr = json['articleNr'];
    articleNr2 = json['articleNr2'];
    language = json['language'];
    cYear = json['c_year'];
    cName = json['c_name'];
    pYear = json['p_year'];
    pName = json['p_name'];
    hideSnippets = json['hideSnippets'];
    bundleOnly = json['bundleOnly'];
    freeStreaming = json['freeStreaming'];
    explicitContent = json['explicitContent'];
    junoGenre = json['junoGenre'];
    youtubeGenre = json['youtubeGenre'];
    youtubePolicy = json['youtubePolicy'];
    phononetGenre = json['phononetGenre'];
    phononetWholesale = json['phononetWholesale'];
    phononetRetail = json['phononetRetail'];
    phononetType = json['phononetType'];
    externalGenre = json['externalGenre'];
    amazonPriceUS = json['amazonPriceUS'];
    amazonPriceEU = json['amazonPriceEU'];
    kontorPrimaryGenre = json['kontorPrimaryGenre'];
    kontorSecondaryGenre = json['kontorSecondaryGenre'];
    detailsInvoice = json['details_invoice'];
    detailsDelivery = json['details_delivery'];
    agree = json['agree'];
    approved = json['approved'];
    deliveryInProgress = json['delivery_in_progress'];
    isTemp = json['isTemp'];
    imported = json['imported'];
    completed1 = json['completed1'];
    completed2 = json['completed2'];
    completed3 = json['completed3'];
    completed4 = json['completed4'];
    completed5 = json['completed5'];
    toDelete = json['to_delete'];
    promo = json['promo'];
    onCloud = json['on_cloud'];
    cloudUploadFailed = json['cloud_upload_failed'];
    archived = json['archived'];
    physical = json['physical'];
    trackCount = json['trackCount'];
    googleDeliveryType = json['googleDeliveryType'];
    listenBeforeRelease = json['listenBeforeRelease'];
    audioBook = json['audioBook'];
    restrictCountry = json['restrict_country'];
    readyForDelivery = json['ready_for_delivery'];
    emailContact = json['email_contact'];
    releaseNote = json['release_note'];
    locked = json['locked'];
    bookCopyright = json['book_copyright'];
    bookDescription = json['book_description'];
    userUnlocked = json['user_unlocked'];
    smsMerchandise = json['sms_merchandise'];
    freeDownload = json['free_download'];
    salesCount = json['sales_count'];
    cloudInProgress = json['cloud_in_progress'];
    reportingPriority = json['reporting_priority'];
    royalty = json['royalty'];
    shop = json['shop'];
    suisa = json['suisa'];
    vat = json['vat'];
    trans = json['trans'];
    total = json['total'];
    streams = json['streams'];
    downloads = json['downloads'];
    physicalFeesPicking = json['physical_fees_picking'];
    physicalReservePublishing = json['physical_reserve_publishing'];
    physicalReserveRefund = json['physical_reserve_refund'];
    vatPercent = json['vat_percent'];
    type = json['type'];
    rows = json['rows'];
    fullArtist = json['fullArtist'];
    fullTitle = json['fullTitle'];
    currency = json['currency'];
    fRoyalty = json['f_royalty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['idRecordjetGenre'] = idRecordjetGenre;
    data['idServiceProvider'] = idServiceProvider;
    data['idExternal'] = idExternal;
    data['idDeal'] = idDeal;
    data['idPremiumDeal'] = idPremiumDeal;
    data['product_type'] = productType;
    data['idProduct'] = idProduct;
    data['songPrice'] = songPrice;
    data['idSongPrice'] = idSongPrice;
    data['bundlePrice'] = bundlePrice;
    data['idBundlePrice'] = idBundlePrice;
    data['mediaType'] = mediaType;
    data['date_added'] = dateAdded;
    data['date_modified'] = dateModified;
    data['date_archived'] = dateArchived;
    data['date_first'] = dateFirst;
    data['date_release'] = dateRelease;
    data['date_release_original'] = dateReleaseOriginal;
    data['date_release_time'] = dateReleaseTime;
    data['date_sale_start'] = dateSaleStart;
    data['date_sale_end'] = dateSaleEnd;
    data['date_approved'] = dateApproved;
    data['date_reminded'] = dateReminded;
    data['date_delivered'] = dateDelivered;
    data['date_preorder'] = datePreorder;
    data['date_streaming'] = dateStreaming;
    data['date_last_cloud_upload'] = dateLastCloudUpload;
    data['date_last_encoded'] = dateLastEncoded;
    data['cover'] = cover;
    data['cover_external'] = coverExternal;
    data['audioExternal'] = audioExternal;
    data['title'] = title;
    data['titleVersion'] = titleVersion;
    data['artist'] = artist;
    data['display_artist'] = displayArtist;
    if (featuring != null) {
      data['featuring'] = featuring!.map((v) => v.toJson()).toList();
    }
    data['label'] = label;
    data['eanCode'] = eanCode;
    data['articleNr'] = articleNr;
    data['articleNr2'] = articleNr2;
    data['language'] = language;
    data['c_year'] = cYear;
    data['c_name'] = cName;
    data['p_year'] = pYear;
    data['p_name'] = pName;
    data['hideSnippets'] = hideSnippets;
    data['bundleOnly'] = bundleOnly;
    data['freeStreaming'] = freeStreaming;
    data['explicitContent'] = explicitContent;
    data['junoGenre'] = junoGenre;
    data['youtubeGenre'] = youtubeGenre;
    data['youtubePolicy'] = youtubePolicy;
    data['phononetGenre'] = phononetGenre;
    data['phononetWholesale'] = phononetWholesale;
    data['phononetRetail'] = phononetRetail;
    data['phononetType'] = phononetType;
    data['externalGenre'] = externalGenre;
    data['amazonPriceUS'] = amazonPriceUS;
    data['amazonPriceEU'] = amazonPriceEU;
    data['kontorPrimaryGenre'] = kontorPrimaryGenre;
    data['kontorSecondaryGenre'] = kontorSecondaryGenre;
    data['details_invoice'] = detailsInvoice;
    data['details_delivery'] = detailsDelivery;
    data['agree'] = agree;
    data['approved'] = approved;
    data['delivery_in_progress'] = deliveryInProgress;
    data['isTemp'] = isTemp;
    data['imported'] = imported;
    data['completed1'] = completed1;
    data['completed2'] = completed2;
    data['completed3'] = completed3;
    data['completed4'] = completed4;
    data['completed5'] = completed5;
    data['to_delete'] = toDelete;
    data['promo'] = promo;
    data['on_cloud'] = onCloud;
    data['cloud_upload_failed'] = cloudUploadFailed;
    data['archived'] = archived;
    data['physical'] = physical;
    data['trackCount'] = trackCount;
    data['googleDeliveryType'] = googleDeliveryType;
    data['listenBeforeRelease'] = listenBeforeRelease;
    data['audioBook'] = audioBook;
    data['restrict_country'] = restrictCountry;
    data['ready_for_delivery'] = readyForDelivery;
    data['email_contact'] = emailContact;
    data['release_note'] = releaseNote;
    data['locked'] = locked;
    data['book_copyright'] = bookCopyright;
    data['book_description'] = bookDescription;
    data['user_unlocked'] = userUnlocked;
    data['sms_merchandise'] = smsMerchandise;
    data['free_download'] = freeDownload;
    data['sales_count'] = salesCount;
    data['cloud_in_progress'] = cloudInProgress;
    data['reporting_priority'] = reportingPriority;
    data['royalty'] = royalty;
    data['shop'] = shop;
    data['suisa'] = suisa;
    data['vat'] = vat;
    data['trans'] = trans;
    data['total'] = total;
    data['streams'] = streams;
    data['downloads'] = downloads;
    data['physical_fees_picking'] = physicalFeesPicking;
    data['physical_reserve_publishing'] = physicalReservePublishing;
    data['physical_reserve_refund'] = physicalReserveRefund;
    data['vat_percent'] = vatPercent;
    data['type'] = type;
    data['rows'] = rows;
    data['fullArtist'] = fullArtist;
    data['fullTitle'] = fullTitle;
    data['currency'] = currency;
    data['f_royalty'] = fRoyalty;
    return data;
  }
}

class Stores {
  String? royalty;
  String? shop;
  String? suisa;
  String? vat;
  String? trans;
  String? total;
  String? streams;
  String? downloads;
  String? physical;
  String? vatPercent;
  String? type;
  String? name;
  String? groupName;
  String? reports;
  String? idPartner;
  String? currency;
  String? compactPeriod;

  Stores(
      {this.royalty,
      this.shop,
      this.suisa,
      this.vat,
      this.trans,
      this.total,
      this.streams,
      this.downloads,
      this.physical,
      this.vatPercent,
      this.type,
      this.name,
      this.groupName,
      this.reports,
      this.idPartner,
      this.currency,
      this.compactPeriod});

  Stores.fromJson(Map<String, dynamic> json) {
    royalty = json['royalty'];
    shop = json['shop'];
    suisa = json['suisa'];
    vat = json['vat'];
    trans = json['trans'];
    total = json['total'];
    streams = json['streams'];
    downloads = json['downloads'];
    physical = json['physical'];
    vatPercent = json['vat_percent'];
    type = json['type'];
    name = json['name'];
    groupName = json['group_name'];
    reports = json['reports'];
    idPartner = json['idPartner'];
    currency = json['currency'];
    compactPeriod = json['compact_period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['royalty'] = royalty;
    data['shop'] = shop;
    data['suisa'] = suisa;
    data['vat'] = vat;
    data['trans'] = trans;
    data['total'] = total;
    data['streams'] = streams;
    data['downloads'] = downloads;
    data['physical'] = physical;
    data['vat_percent'] = vatPercent;
    data['type'] = type;
    data['name'] = name;
    data['group_name'] = groupName;
    data['reports'] = reports;
    data['idPartner'] = idPartner;
    data['currency'] = currency;
    data['compact_period'] = compactPeriod;
    return data;
  }
}

class Totals {
  double? fRoyalty;
  double? royalty;
  double? shop;
  int? vat;
  int? suisa;
  double? trans;
  double? total;
  int? physicalReservePublishing;
  int? physicalReserveRefund;
  int? physicalFeesPicking;
  int? rows;
  int? vat000;
  List<dynamic>? physicalReserveDetailed;

  Totals(
      {this.fRoyalty,
      this.royalty,
      this.shop,
      this.vat,
      this.suisa,
      this.trans,
      this.total,
      this.physicalReservePublishing,
      this.physicalReserveRefund,
      this.physicalFeesPicking,
      this.rows,
      this.vat000,
      this.physicalReserveDetailed});

  Totals.fromJson(Map<String, dynamic> json) {
    fRoyalty = json['f_royalty'];
    royalty = json['royalty'];
    shop = json['shop'];
    vat = json['vat'];
    suisa = json['suisa'];
    trans = json['trans'];
    total = json['total'];
    physicalReservePublishing = json['physical_reserve_publishing'];
    physicalReserveRefund = json['physical_reserve_refund'];
    physicalFeesPicking = json['physical_fees_picking'];
    rows = json['rows'];
    vat000 = json['vat_0.00'];
    if (json['physical_reserve_detailed'] != null) {
      physicalReserveDetailed = <Null>[];
      json['physical_reserve_detailed'].forEach((v) {
        physicalReserveDetailed!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_royalty'] = fRoyalty;
    data['royalty'] = royalty;
    data['shop'] = shop;
    data['vat'] = vat;
    data['suisa'] = suisa;
    data['trans'] = trans;
    data['total'] = total;
    data['physical_reserve_publishing'] = physicalReservePublishing;
    data['physical_reserve_refund'] = physicalReserveRefund;
    data['physical_fees_picking'] = physicalFeesPicking;
    data['rows'] = rows;
    data['vat_0.00'] = vat000;
    if (physicalReserveDetailed != null) {
      data['physical_reserve_detailed'] =
          physicalReserveDetailed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
