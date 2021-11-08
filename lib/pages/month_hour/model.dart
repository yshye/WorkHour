class MonthHourStatistics {
  late List<StatisticsItem> _items;

  /// 工作日\休息日\法定节假日加班总和
  num _weekdays = 0, _weekend = 0, _holiday = 0;

  num get weekdays => _weekdays;

  num get weekend => _weekend;

  num get holiday => _holiday;

  /// 请假总和
  num leave = 0;

  MonthHourStatistics(List<StatisticsItem> items) {
    this.items = items;
  }

  MonthHourStatistics.fromJson(List list) {
    items = list.map((e) => StatisticsItem.fromJson(e)).toList();
  }

  List<StatisticsItem> get items => _items;

  set items(List<StatisticsItem> items) {
    _items = items;
    for (var element in items) {
      leave += element.sumLeaveHour;
      switch (element.dateType) {
        case 1:
          _weekend = element.sumOverWorkHour;
          break;
        case 2:
          _holiday = element.sumOverWorkHour;
          break;
        default:
          _weekdays = element.sumOverWorkHour;
          break;
      }
    }
  }

  num get price {
    var _sum1 = _weekdays - leave;
    if (_sum1 < 0) {
      var __weekend = _weekend + _sum1;
      if (__weekend < 0) {
        return _holiday * 16 * 3;
      }
      return (_holiday * 3 + __weekend * 2) * 16;
    }
    return (_holiday * 3 + _weekend * 2 + _sum1 * 1.5) * 16;
  }
}

class StatisticsItem {
  /// 考勤日总数
  // late int count;

  /// 请假总工时
  late num sumLeaveHour;

  /// 加班总工时
  late num sumOverWorkHour;

  /// 0-工作日，1-周末，2-法定节假日
  late int dateType;

  StatisticsItem(
    // this.count,
    this.sumLeaveHour,
    this.sumOverWorkHour,
    this.dateType,
  );

  StatisticsItem.fromJson(Map<String, dynamic> json) {
    // count = json['_count'];
    sumLeaveHour = json['_sumLeaveHour'];
    sumOverWorkHour = json['_sumOverWorkHour'];
    dateType = json['dateType'];
  }
}
