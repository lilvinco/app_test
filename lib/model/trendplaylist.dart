class TrendPlaylist {
  int? status;
  List<Releases>? releases;
  Totals? totals;
  Statistics? statistics;

  TrendPlaylist({this.status, this.releases, this.totals, this.statistics});

  TrendPlaylist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['releases'] != null) {
      releases = <Releases>[];
      json['releases'].forEach((v) {
        releases!.add(Releases.fromJson(v));
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
    if (releases != null) {
      data['releases'] = releases!.map((Releases v) => v.toJson()).toList();
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

class Releases {
  String? id;
  String? title;
  String? titleVersion;
  List<String>? artist;
  List<dynamic>? featuring;
  String? royalties;
  String? selected;
  String? fullArtist;
  String? fullTitle;

  Releases(
      {this.id,
      this.title,
      this.titleVersion,
      this.artist,
      this.featuring,
      this.royalties,
      this.selected,
      this.fullArtist,
      this.fullTitle});

  Releases.fromJson(Map<String, dynamic> json) {
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
  List<dynamic>? order;
  List<String>? labels;
  String? prefix;

  Chart({this.series, this.order, this.labels, this.prefix});

  Chart.fromJson(Map<String, dynamic> json) {
    if (json['series'] != null) {
      series = <dynamic>[];
      json['series'].forEach((v) {
        series!.add(v);
      });
    }
    if (json['order'] != null) {
      order = <dynamic>[];
      json['order'].forEach((v) {
        order!.add(v);
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
  List<DonutChart>? chart;
  String? totalTitle;

  Donut(
      {this.total,
      this.totalQuantity,
      this.totalRevenues,
      this.chart,
      this.totalTitle});

  Donut.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalQuantity = json['total_quantity'];
    totalRevenues = json['total_revenues'];
    if (json['chart'] != null) {
      chart = <DonutChart>[];
      json['chart'].forEach((v) {
        chart!.add(DonutChart.fromJson(v));
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
      data['chart'] = chart!.map((DonutChart v) => v.toJson()).toList();
    }
    data['total_title'] = totalTitle;
    return data;
  }
}

class DonutChart {
  String? name;
  int? y;
  String? value;

  DonutChart({this.name, this.y, this.value});

  DonutChart.fromJson(Map<String, dynamic> json) {
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
