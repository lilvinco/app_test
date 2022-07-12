class TrendStoreDetail {
  int? status;
  List<Release>? release;
  Totals? totals;
  Statistics? statistics;

  TrendStoreDetail({this.status, this.release, this.totals, this.statistics});

  TrendStoreDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['release'] != null) {
      release = <Release>[];
      json['release'].forEach((v) {
        release!.add(Release.fromJson(v));
      });
    }
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (release != null) {
      data['release'] = release!.map((Release v) => v.toJson()).toList();
    }
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    return data;
  }
}

class Release {
  String? id;
  String? title;
  String? titleVersion;
  List<String>? artist;
  List<dynamic>? featuring;
  String? royalties;
  String? selected;
  String? fullArtist;
  String? fullTitle;

  Release(
      {this.id,
      this.title,
      this.titleVersion,
      this.artist,
      this.featuring,
      this.royalties,
      this.selected,
      this.fullArtist,
      this.fullTitle});

  Release.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleVersion = json['titleVersion'];
    artist = json['artist'].cast<String>();
    if (json['featuring'] != null) {
      featuring = <dynamic>[];
      json['featuring'].forEach((v) {
        featuring!.add(v);
      });
    }
    royalties = json['royalties'];
    selected = json['selected'];
    fullArtist = json['fullArtist'];
    fullTitle = json['fullTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['titleVersion'] = titleVersion;
    data['artist'] = artist;
    if (featuring != null) {
      data['featuring'] = featuring!.map((v) => v.toJson()).toList();
    }
    data['royalties'] = royalties;
    data['selected'] = selected;
    data['fullArtist'] = fullArtist;
    data['fullTitle'] = fullTitle;
    return data;
  }
}

class Totals {
  Overview? overview;
  Charts? charts;

  Totals({this.overview, this.charts});

  Totals.fromJson(Map<String, dynamic> json) {
    overview =
        json['overview'] != null ? Overview.fromJson(json['overview']) : null;
    charts = json['charts'] != null ? Charts.fromJson(json['charts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (overview != null) {
      data['overview'] = overview!.toJson();
    }
    if (charts != null) {
      data['charts'] = charts!.toJson();
    }
    return data;
  }
}

class Overview {
  dynamic royalty;
  dynamic streams;
  dynamic downloads;
  int? downloadsLast;
  int? streamsLast;
  int? royaltyLast;
  int? royaltyChange;
  int? downloadsChange;
  int? streamsChange;

  Overview(
      {this.royalty,
      this.streams,
      this.downloads,
      this.downloadsLast,
      this.streamsLast,
      this.royaltyLast,
      this.royaltyChange,
      this.downloadsChange,
      this.streamsChange});

  Overview.fromJson(Map<String, dynamic> json) {
    royalty = json['royalty'];
    streams = json['streams'];
    downloads = json['downloads'];
    downloadsLast = json['downloads_last'];
    streamsLast = json['streams_last'];
    royaltyLast = json['royalty_last'];
    royaltyChange = json['royalty_change'];
    downloadsChange = json['downloads_change'];
    streamsChange = json['streams_change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['royalty'] = royalty;
    data['streams'] = streams;
    data['downloads'] = downloads;
    data['downloads_last'] = downloadsLast;
    data['streams_last'] = streamsLast;
    data['royalty_last'] = royaltyLast;
    data['royalty_change'] = royaltyChange;
    data['downloads_change'] = downloadsChange;
    data['streams_change'] = streamsChange;
    return data;
  }
}

class Charts {
  ChartStreams? chartStreams;
  ChartRoyalties? chartRoyalties;
  ChartDownloads? chartDownloads;

  Charts({this.chartStreams, this.chartRoyalties, this.chartDownloads});

  Charts.fromJson(Map<String, dynamic> json) {
    chartStreams = json['chart_streams'] != null
        ? ChartStreams.fromJson(json['chart_streams'])
        : null;
    chartRoyalties = json['chart_royalties'] != null
        ? ChartRoyalties.fromJson(json['chart_royalties'])
        : null;
    chartDownloads = json['chart_downloads'] != null
        ? ChartDownloads.fromJson(json['chart_downloads'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chartStreams != null) {
      data['chart_streams'] = chartStreams!.toJson();
    }
    if (chartRoyalties != null) {
      data['chart_royalties'] = chartRoyalties!.toJson();
    }
    if (chartDownloads != null) {
      data['chart_downloads'] = chartDownloads!.toJson();
    }
    return data;
  }
}

class ChartStreams {
  String? name;
  List<String>? labels;
  List<int>? values;

  ChartStreams({this.name, this.labels, this.values});

  ChartStreams.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    labels = json['labels'].cast<String>();
    values = json['values'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['labels'] = labels;
    data['values'] = values;
    return data;
  }
}

class ChartRoyalties {
  String? name;
  List<String>? labels;
  List<int>? values;

  ChartRoyalties({this.name, this.labels, this.values});

  ChartRoyalties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    labels = json['labels'].cast<String>();
    values = json['values'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['labels'] = labels;
    data['values'] = values;
    return data;
  }
}

class ChartDownloads {
  String? name;
  List<String>? labels;
  List<int>? values;

  ChartDownloads({this.name, this.labels, this.values});

  ChartDownloads.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    labels = json['labels'].cast<String>();
    values = json['values'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['labels'] = labels;
    data['values'] = values;
    return data;
  }
}

class Statistics {
  List<dynamic>? table;
  Chart? chart;
  Donut? donut;
  List<dynamic>? totals;

  Statistics({this.table, this.chart, this.donut, this.totals});

  Statistics.fromJson(Map<String, dynamic> json) {
    if (json['table'] != null) {
      table = <dynamic>[];
      json['table'].forEach((v) {
        table!.add(v);
      });
    }
    chart = json['chart'] != null ? Chart.fromJson(json['chart']) : null;
    donut = json['donut'] != null ? Donut.fromJson(json['donut']) : null;
    if (json['totals'] != null) {
      totals = <dynamic>[];
      json['totals'].forEach((v) {
        totals!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (table != null) {
      data['table'] = table!.map((v) => v.toJson()).toList();
    }
    if (chart != null) {
      data['chart'] = chart!.toJson();
    }
    if (donut != null) {
      data['donut'] = donut!.toJson();
    }
    if (totals != null) {
      data['totals'] = totals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chart {
  List<dynamic>? series;
  List<dynamic>? seriesQuantity;
  List<dynamic>? order;
  List<String>? labels;
  String? prefix;

  Chart(
      {this.series, this.seriesQuantity, this.order, this.labels, this.prefix});

  Chart.fromJson(Map<String, dynamic> json) {
    if (json['series'] != null) {
      series = <dynamic>[];
      json['series'].forEach((v) {
        series!.add((v));
      });
    }
    if (json['series_quantity'] != null) {
      seriesQuantity = <dynamic>[];
      json['series_quantity'].forEach((v) {
        seriesQuantity!.add((v));
      });
    }
    if (json['order'] != null) {
      order = <dynamic>[];
      json['order'].forEach((v) {
        order!.add((v));
      });
    }
    labels = json['labels'].cast<String>();
    prefix = json['prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (series != null) {
      data['series'] = series!.map((v) => v.toJson()).toList();
    }
    if (seriesQuantity != null) {
      data['series_quantity'] = seriesQuantity!.map((v) => v.toJson()).toList();
    }
    if (order != null) {
      data['order'] = order!.map((v) => v.toJson()).toList();
    }
    data['labels'] = labels;
    data['prefix'] = prefix;
    return data;
  }
}

class Donut {
  int? total;
  int? totalQuantity;
  int? totalRevenues;
  List<Chart>? chart;
  List<ChartQuantity>? chartQuantity;
  String? totalTitle;

  Donut(
      {this.total,
      this.totalQuantity,
      this.totalRevenues,
      this.chart,
      this.chartQuantity,
      this.totalTitle});

  Donut.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalQuantity = json['total_quantity'];
    totalRevenues = json['total_revenues'];
    if (json['chart'] != null) {
      chart = <Chart>[];
      json['chart'].forEach((v) {
        chart!.add(Chart.fromJson(v));
      });
    }
    if (json['chart_quantity'] != null) {
      chartQuantity = <ChartQuantity>[];
      json['chart_quantity'].forEach((v) {
        chartQuantity!.add(ChartQuantity.fromJson(v));
      });
    }
    totalTitle = json['total_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['total_quantity'] = totalQuantity;
    data['total_revenues'] = totalRevenues;
    if (chart != null) {
      data['chart'] = chart!.map((Chart v) => v.toJson()).toList();
    }
    if (chartQuantity != null) {
      data['chart_quantity'] =
          chartQuantity!.map((ChartQuantity v) => v.toJson()).toList();
    }
    data['total_title'] = totalTitle;
    return data;
  }
}

class NChart {
  String? name;
  int? y;
  String? value;

  NChart({this.name, this.y, this.value});

  NChart.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    y = json['y'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['y'] = y;
    data['value'] = value;
    return data;
  }
}

class ChartQuantity {
  String? name;
  int? y;
  String? value;

  ChartQuantity({this.name, this.y, this.value});

  ChartQuantity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    y = json['y'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['y'] = y;
    data['value'] = value;
    return data;
  }
}
