class DashboardActiveWidgets {
  bool? income;
  bool? topTrends;
  bool? growth;
  bool? nextPayout;
  bool? prognoses;
  bool? age;

  DashboardActiveWidgets(
      {this.income,
      this.topTrends,
      this.growth,
      this.nextPayout,
      this.prognoses,
      this.age});

  DashboardActiveWidgets.fromJson(Map<String, dynamic> json) {
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
