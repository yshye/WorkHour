class MonthHourStatistics {
  late List<StatisticsItem> _items;

  /// 工作日\休息日\法定节假日加班总和
  num sum1 = 0, sum2 = 0, sum3 = 0;

  /// 请假总和
  num leave = 0;

  MonthHourStatistics(this._items,
      {this.sum1 = 0, this.sum2 = 0, this.sum3 = 0, this.leave = 0});

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
          sum2 = element.sumOverWorkHour;
          break;
        case 2:
          sum3 = element.sumOverWorkHour;
          break;
        default:
          sum1 = element.sumOverWorkHour;
          break;
      }
    }
  }

  num get price {
    var _sum1 = sum1 - leave;
    if (_sum1 < 0) {
      var _sum2 = sum2 + _sum1;
      if (_sum2 < 0) {
        return sum3 * 16 * 3;
      }
      return (sum3 * 3 + _sum2 * 2) * 16;
    }
    return (sum3 * 3 + sum2 * 2 + _sum1 * 1.5) * 16;
  }
}

class StatisticsItem {
  /// 考勤日总数
  late int count;

  /// 请假总工时
  late num sumLeaveHour;

  /// 加班总工时
  late num sumOverWorkHour;

  /// 0-工作日，1-周末，2-法定节假日
  late int dateType;

  StatisticsItem(
    this.count,
    this.sumLeaveHour,
    this.sumOverWorkHour,
    this.dateType,
  );

  StatisticsItem.fromJson(Map<String, dynamic> json) {
    count = json['_count'];
    sumLeaveHour = json['_sumLeaveHour'];
    sumOverWorkHour = json['_sumOverWorkHour'];
    dateType = json['dateType'];
  }
}
