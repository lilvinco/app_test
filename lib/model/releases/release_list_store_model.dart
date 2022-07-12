class ReleaseListStoreModel {
  int? status;
  Payload? payload;

  ReleaseListStoreModel({this.status, this.payload});

  ReleaseListStoreModel.fromJson(Map<String, dynamic> json) {
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
  StorePartners? partners;

  Payload({this.partners});

  Payload.fromJson(Map<String, dynamic> json) {
    partners = json['partners'] != null
        ? StorePartners.fromJson(json['partners'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (partners != null) {
      data['partners'] = partners!.toJson();
    }
    return data;
  }
}

class StorePartners {
  List<Streaming>? streaming;
  List<Listen>? listen;
  List<Download>? download;

  StorePartners({this.streaming, this.listen, this.download});

  StorePartners.fromJson(Map<String, dynamic> json) {
    if (json['streaming'] != null) {
      streaming = <Streaming>[];
      json['streaming'].forEach((v) {
        streaming!.add(Streaming.fromJson(v));
      });
    }
    if (json['listen'] != null) {
      listen = <Listen>[];
      json['listen'].forEach((v) {
        listen!.add(Listen.fromJson(v));
      });
    }
    if (json['download'] != null) {
      download = <Download>[];
      json['download'].forEach((v) {
        download!.add(Download.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (streaming != null) {
      data['streaming'] = streaming!.map((Streaming v) => v.toJson()).toList();
    }
    if (listen != null) {
      data['listen'] = listen!.map((Listen v) => v.toJson()).toList();
    }
    if (download != null) {
      data['download'] = download!.map((Download v) => v.toJson()).toList();
    }
    return data;
  }
}

class Streaming {
  String? id;
  String? idServiceProvider;
  String? idPhysicalPartner;
  String? code;
  String? name;
  String? groupName;
  String? free;
  String? mandatory;
  String? visible;
  String? adminVisible;
  String? serviceType;
  String? importTrends;
  String? importReportDelay;
  String? priority;
  List<String>? variants;
  String? adminOrder;
  String? showLinkSite;
  String? extWarehouseId;
  String? dspName;
  String? classDelivery;
  String? classImport;
  String? classReporting;
  String? genres;

  Streaming(
      {this.id,
      this.idServiceProvider,
      this.idPhysicalPartner,
      this.code,
      this.name,
      this.groupName,
      this.free,
      this.mandatory,
      this.visible,
      this.adminVisible,
      this.serviceType,
      this.importTrends,
      this.importReportDelay,
      this.priority,
      this.variants,
      this.adminOrder,
      this.showLinkSite,
      this.extWarehouseId,
      this.dspName,
      this.classDelivery,
      this.classImport,
      this.classReporting,
      this.genres});

  Streaming.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idServiceProvider = json['idServiceProvider'];
    idPhysicalPartner = json['idPhysicalPartner'];
    code = json['code'];
    name = json['name'];
    groupName = json['group_name'];
    free = json['free'];
    mandatory = json['mandatory'];
    visible = json['visible'];
    adminVisible = json['admin_visible'];
    serviceType = json['serviceType'];
    importTrends = json['importTrends'];
    importReportDelay = json['importReportDelay'];
    priority = json['priority'];
    variants = json['variants'].cast<String>();
    adminOrder = json['admin_order'];
    showLinkSite = json['showLinkSite'];
    extWarehouseId = json['ext_warehouse_id'];
    dspName = json['dsp_name'];
    classDelivery = json['classDelivery'];
    classImport = json['classImport'];
    classReporting = json['classReporting'];
    genres = json['genres'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idServiceProvider'] = idServiceProvider;
    data['idPhysicalPartner'] = idPhysicalPartner;
    data['code'] = code;
    data['name'] = name;
    data['group_name'] = groupName;
    data['free'] = free;
    data['mandatory'] = mandatory;
    data['visible'] = visible;
    data['admin_visible'] = adminVisible;
    data['serviceType'] = serviceType;
    data['importTrends'] = importTrends;
    data['importReportDelay'] = importReportDelay;
    data['priority'] = priority;
    data['variants'] = variants;
    data['admin_order'] = adminOrder;
    data['showLinkSite'] = showLinkSite;
    data['ext_warehouse_id'] = extWarehouseId;
    data['dsp_name'] = dspName;
    data['classDelivery'] = classDelivery;
    data['classImport'] = classImport;
    data['classReporting'] = classReporting;
    data['genres'] = genres;
    return data;
  }
}

class Listen {
  String? id;
  String? idServiceProvider;
  String? idPhysicalPartner;
  String? code;
  String? name;
  String? groupName;
  String? free;
  String? mandatory;
  String? visible;
  String? adminVisible;
  String? serviceType;
  String? importTrends;
  String? importReportDelay;
  String? priority;
  List<String>? variants;
  String? adminOrder;
  String? showLinkSite;
  String? extWarehouseId;
  String? dspName;
  String? classDelivery;
  String? classImport;
  String? classReporting;
  String? genres;

  Listen(
      {this.id,
      this.idServiceProvider,
      this.idPhysicalPartner,
      this.code,
      this.name,
      this.groupName,
      this.free,
      this.mandatory,
      this.visible,
      this.adminVisible,
      this.serviceType,
      this.importTrends,
      this.importReportDelay,
      this.priority,
      this.variants,
      this.adminOrder,
      this.showLinkSite,
      this.extWarehouseId,
      this.dspName,
      this.classDelivery,
      this.classImport,
      this.classReporting,
      this.genres});

  Listen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idServiceProvider = json['idServiceProvider'];
    idPhysicalPartner = json['idPhysicalPartner'];
    code = json['code'];
    name = json['name'];
    groupName = json['group_name'];
    free = json['free'];
    mandatory = json['mandatory'];
    visible = json['visible'];
    adminVisible = json['admin_visible'];
    serviceType = json['serviceType'];
    importTrends = json['importTrends'];
    importReportDelay = json['importReportDelay'];
    priority = json['priority'];
    variants = json['variants'].cast<String>();
    adminOrder = json['admin_order'];
    showLinkSite = json['showLinkSite'];
    extWarehouseId = json['ext_warehouse_id'];
    dspName = json['dsp_name'];
    classDelivery = json['classDelivery'];
    classImport = json['classImport'];
    classReporting = json['classReporting'];
    genres = json['genres'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idServiceProvider'] = idServiceProvider;
    data['idPhysicalPartner'] = idPhysicalPartner;
    data['code'] = code;
    data['name'] = name;
    data['group_name'] = groupName;
    data['free'] = free;
    data['mandatory'] = mandatory;
    data['visible'] = visible;
    data['admin_visible'] = adminVisible;
    data['serviceType'] = serviceType;
    data['importTrends'] = importTrends;
    data['importReportDelay'] = importReportDelay;
    data['priority'] = priority;
    data['variants'] = variants;
    data['admin_order'] = adminOrder;
    data['showLinkSite'] = showLinkSite;
    data['ext_warehouse_id'] = extWarehouseId;
    data['dsp_name'] = dspName;
    data['classDelivery'] = classDelivery;
    data['classImport'] = classImport;
    data['classReporting'] = classReporting;
    data['genres'] = genres;
    return data;
  }
}

class Download {
  String? id;
  String? idServiceProvider;
  String? idPhysicalPartner;
  String? code;
  String? name;
  String? groupName;
  String? free;
  String? mandatory;
  String? visible;
  String? adminVisible;
  String? serviceType;
  String? importTrends;
  String? importReportDelay;
  String? priority;
  List<String>? variants;
  String? adminOrder;
  String? showLinkSite;
  String? extWarehouseId;
  String? dspName;
  String? classDelivery;
  String? classImport;
  String? classReporting;
  String? genres;

  Download(
      {this.id,
      this.idServiceProvider,
      this.idPhysicalPartner,
      this.code,
      this.name,
      this.groupName,
      this.free,
      this.mandatory,
      this.visible,
      this.adminVisible,
      this.serviceType,
      this.importTrends,
      this.importReportDelay,
      this.priority,
      this.variants,
      this.adminOrder,
      this.showLinkSite,
      this.extWarehouseId,
      this.dspName,
      this.classDelivery,
      this.classImport,
      this.classReporting,
      this.genres});

  Download.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idServiceProvider = json['idServiceProvider'];
    idPhysicalPartner = json['idPhysicalPartner'];
    code = json['code'];
    name = json['name'];
    groupName = json['group_name'];
    free = json['free'];
    mandatory = json['mandatory'];
    visible = json['visible'];
    adminVisible = json['admin_visible'];
    serviceType = json['serviceType'];
    importTrends = json['importTrends'];
    importReportDelay = json['importReportDelay'];
    priority = json['priority'];
    variants = json['variants'].cast<String>();
    adminOrder = json['admin_order'];
    showLinkSite = json['showLinkSite'];
    extWarehouseId = json['ext_warehouse_id'];
    dspName = json['dsp_name'];
    classDelivery = json['classDelivery'];
    classImport = json['classImport'];
    classReporting = json['classReporting'];
    genres = json['genres'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idServiceProvider'] = idServiceProvider;
    data['idPhysicalPartner'] = idPhysicalPartner;
    data['code'] = code;
    data['name'] = name;
    data['group_name'] = groupName;
    data['free'] = free;
    data['mandatory'] = mandatory;
    data['visible'] = visible;
    data['admin_visible'] = adminVisible;
    data['serviceType'] = serviceType;
    data['importTrends'] = importTrends;
    data['importReportDelay'] = importReportDelay;
    data['priority'] = priority;
    data['variants'] = variants;
    data['admin_order'] = adminOrder;
    data['showLinkSite'] = showLinkSite;
    data['ext_warehouse_id'] = extWarehouseId;
    data['dsp_name'] = dspName;
    data['classDelivery'] = classDelivery;
    data['classImport'] = classImport;
    data['classReporting'] = classReporting;
    data['genres'] = genres;
    return data;
  }
}
