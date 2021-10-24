import 'package:get/get.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:work_hour/bmob/net_helper.dart';
import 'package:work_hour/bmob/table/work_info.dart';

import 'model.dart';

class MonthHourLogic extends GetxController {

  late MonthHourStatistics statistics;
  late DateMonth month;
  List<WorkInfo> workInfoList = [];

  @override
  void onInit() {
    DateTime _now = DateTime.now();
    month = DateMonth(_now.year, _now.day > 25 ? _now.month + 1 : _now.month);
    statistics = MonthHourStatistics([]);
    changeMonth(month);
    super.onInit();
  }


  void last() =>
      changeMonth(DateMonth(month.year, month.month - 1));


  void next() =>
      changeMonth(DateMonth(month.year, month.month + 1));

  void changeMonth(DateMonth month) async {
    this.month = month;

    BmobNetHelper.workHourList(month).then((value) {
      workInfoList = value;
      update();
    });

    BmobNetHelper.getHourStatistics(month).then((value) {
      statistics = value;
      update();
    });
  }
}
