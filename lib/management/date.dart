import 'package:igroove_fan_box_one/igroove.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:intl/intl.dart';

class DateStartEnd {
  static String? startDate;
  static String? endDate;
}

class DateStartEndParsed {
  static String? startDate;
  static String? endDate;
}

/// holds the date info
enum PeriodType {
  ThisWeek,
  Last30Days,
  LastMonth,
  Last3Month,
  SinceNow,
  Custom
}

class DateInfo {
  final String? start;
  final String? end;

  DateInfo({this.start, this.end});
}

class DateInfoFormatter {
  static DateInfo? dateInfoForType(PeriodType type,
      [DateTime? start, DateTime? end]) {
    DateInfo? dateInfo;
    int endDate;

    if (UserService.userDataModel?.endDate != null) {
      endDate = UserService.userDataModel!.endDate! * 1000;
    } else {
      DateTime now = DateTime.now();
      endDate = now.millisecondsSinceEpoch - (2 * 86400000);
    }

    switch (type) {
      // This Week
      //________________________________________________________________________
      case PeriodType.ThisWeek:
        // replace ts from login * 1000
        DateTime twoDaysAgo = DateTime.fromMillisecondsSinceEpoch(endDate);
        DateTime thisWeek = DateTime.fromMillisecondsSinceEpoch(
            twoDaysAgo.millisecondsSinceEpoch - 6 * 24 * 60 * 60 * 1000);
        DateFormat format =
            DateFormat('yyyy-MM-dd', IGroove.localeSubject.value.languageCode);
        dateInfo = DateInfo(
            start: format.format(thisWeek), end: format.format(twoDaysAgo));
        //_
        DateFormat formatForSow =
            DateFormat('d. MMM yyyy', IGroove.localeSubject.value.languageCode);
        DateStartEndParsed.startDate = formatForSow.format(thisWeek);
        DateStartEndParsed.endDate = formatForSow.format(twoDaysAgo);
        break;
      // Last 30 days
      //________________________________________________________________________
      case PeriodType.Last30Days:
        // replace ts from login
        DateTime twoDaysAgo = DateTime.fromMillisecondsSinceEpoch(endDate);
        DateTime last30day = DateTime.fromMillisecondsSinceEpoch(
                twoDaysAgo.millisecondsSinceEpoch - (28 * 24 * 60 * 60 * 1000))
            .toUtc();
        DateFormat format =
            DateFormat('yyyy-MM-dd', IGroove.localeSubject.value.languageCode);
        dateInfo = DateInfo(
            start: format.format(last30day), end: format.format(twoDaysAgo));
        //_
        DateFormat formatForSow =
            DateFormat('d. MMM yyyy', IGroove.localeSubject.value.languageCode);
        DateStartEndParsed.startDate = formatForSow.format(last30day);
        DateStartEndParsed.endDate = formatForSow.format(twoDaysAgo);
        break;
      // Last Month
      //_______________________________________________________________________
      case PeriodType.LastMonth:
        int lastMonthStartDay = 1;
        int lastMonthEndDay =
            DateTime.now().subtract(Duration(days: DateTime.now().day)).day;
        int thisYear = DateTime.now().year;
        int lastMonthStartYear =
            DateTime.now().month == 1 ? thisYear - 1 : thisYear;
        int thisMonth = DateTime.now().month;
        int lastMonth = thisMonth == 1 ? 12 : thisMonth - 1;

        DateTime firstDayOfLastMonth =
            DateTime(lastMonthStartYear, lastMonth, lastMonthStartDay);
        DateTime lastDayOfLastMonth =
            DateTime(lastMonthStartYear, lastMonth, lastMonthEndDay);

        DateFormat format =
            DateFormat('yyyy-MM-dd', IGroove.localeSubject.value.languageCode);
        dateInfo = DateInfo(
            start: format.format(firstDayOfLastMonth),
            end: format.format(lastDayOfLastMonth));
        //_
        DateFormat formatForSow =
            DateFormat('d. MMM yyyy', IGroove.localeSubject.value.languageCode);
        DateStartEndParsed.startDate = formatForSow.format(firstDayOfLastMonth);
        DateStartEndParsed.endDate = formatForSow.format(lastDayOfLastMonth);
        break;
      // Last 3 Month
      //________________________________________________________________________
      case PeriodType.Last3Month:
        int lastMonthStartDay = 1;
        int lastMonthEndDay =
            DateTime.now().subtract(Duration(days: DateTime.now().day)).day;
        int thisYear = DateTime.now().year;
        int lastMonthStartYear =
            DateTime.now().month == 1 ? thisYear - 1 : thisYear;
        int thisMonth = DateTime.now().month;
        int lastMonth = thisMonth == 1 ? 12 : thisMonth - 1;
        int threeMonthAgo = thisMonth == 1 ? 10 : thisMonth - 3;

        DateTime firstDayOfLast3Month =
            DateTime(lastMonthStartYear, threeMonthAgo, lastMonthStartDay);
        DateTime lastDayOfLastMonth =
            DateTime(lastMonthStartYear, lastMonth, lastMonthEndDay);

        DateFormat format =
            DateFormat('yyyy-MM-dd', IGroove.localeSubject.value.languageCode);
        dateInfo = DateInfo(
            start: format.format(firstDayOfLast3Month),
            end: format.format(lastDayOfLastMonth));
        //_
        DateFormat formatForSow =
            DateFormat('d. MMM yyyy', IGroove.localeSubject.value.languageCode);
        DateStartEndParsed.startDate =
            formatForSow.format(firstDayOfLast3Month);
        DateStartEndParsed.endDate = formatForSow.format(lastDayOfLastMonth);

        break;
      // Since the beginning
      //________________________________________________________________________
      case PeriodType.SinceNow:
        // replace ts from login
        DateTime twoDaysAgo = DateTime.fromMillisecondsSinceEpoch(endDate);
        DateTime sinceNow = DateTime.parse(
            UserService.userDataModel?.sinceBegin ??
                DateTime.fromMillisecondsSinceEpoch(0).toString());
        DateFormat format =
            DateFormat('yyyy-MM-dd', IGroove.localeSubject.value.languageCode);
        dateInfo = DateInfo(
            start: format.format(sinceNow), end: format.format(twoDaysAgo));
        //_
        DateFormat formatForSow =
            DateFormat('d. MMM yyyy', IGroove.localeSubject.value.languageCode);
        DateStartEndParsed.startDate = formatForSow.format(sinceNow);
        DateStartEndParsed.endDate = formatForSow.format(twoDaysAgo);
        break;
      // custom date
      //________________________________________________________________________
      case PeriodType.Custom:
        DateTime selectedStart = start!;
        DateTime selectedEnd = end!;
        DateFormat format =
            DateFormat('yyyy-MM-dd', IGroove.localeSubject.value.languageCode);

        if (selectedEnd.millisecondsSinceEpoch > (endDate)) {
          selectedEnd = DateTime.fromMillisecondsSinceEpoch(endDate);
        }

        dateInfo = DateInfo(
            start: format.format(selectedStart),
            end: format.format(selectedEnd));

        //_
        DateFormat formatForSow =
            DateFormat('d. MMM yyyy', IGroove.localeSubject.value.languageCode);
        DateStartEndParsed.startDate = formatForSow.format(selectedStart);
        DateStartEndParsed.endDate = formatForSow.format(selectedEnd);
        break;
    }

    return dateInfo;
  }

  static DateTime lastDayOfMonth(DateTime month) {
    DateTime beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }
}
