class DashboardTopTrendsTopPlaylists {
  int? status;
  List<DataPlaylist>? data;

  DashboardTopTrendsTopPlaylists({this.status, this.data});

  DashboardTopTrendsTopPlaylists.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataPlaylist>[];
      json['data'].forEach((v) {
        data!.add(DataPlaylist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((DataPlaylist v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataPlaylist {
  String? cover;
  String? title;
  String? subtitle;
  String? total;
  String? totalLast;
  double? change;
  String? percent;

  DataPlaylist(
      {this.cover,
      this.title,
      this.subtitle,
      this.total,
      this.totalLast,
      this.change,
      this.percent});

  DataPlaylist.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    title = json['title'];
    subtitle = json['subtitle'];
    total = json['total'];
    totalLast = json['total_last'];
    change = double.parse("${json['change']}");
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cover'] = cover;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['total'] = total;
    data['total_last'] = totalLast;
    data['change'] = change;
    data['percent'] = percent;
    return data;
  }
}
