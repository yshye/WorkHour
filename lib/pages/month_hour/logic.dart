import 'package:get/get.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:work_hour/bmob/net_helper.dart';
import 'package:work_hour/bmob/tables/work_info.dart';
import 'package:work_hour/utils/pref_util.dart';

import 'model.dart';

class MonthHourLogic extends GetxController {
  late MonthHourStatistics statistics;
  late DateMonth month;
  List<WorkInfoTable> infoList = [];
  // List<WorkInfo> workInfoList = [];

  @override
  void onInit() {
    DateTime _now = DateTime.now();
    month = DateMonth(_now.year, _now.day > 25 ? _now.month + 1 : _now.month);
    statistics = MonthHourStatistics([]);
    changeMonth(month);
    super.onInit();
  }

  void last() => changeMonth(DateMonth(month.year, month.month - 1));

  void next() => changeMonth(DateMonth(month.year, month.month + 1));

  void changeMonth(DateMonth month) async {
    this.month = month;

    BmobNetHelper.infoList(month, prefUtil.user.username!).then((value) {
      infoList = value;
      update();
    });

    BmobNetHelper.getHourStatistics(month, prefUtil.user.username!).then((value) {
      statistics = value;
      update();
    });
  }
}
