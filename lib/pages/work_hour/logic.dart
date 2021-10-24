import 'package:get/get.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:work_hour/bmob/net_helper.dart';
import 'package:work_hour/bmob/table/work_info.dart';

import '../month_hour/model.dart';

class WorkHourLogic extends GetxController {
  late MonthOption<WorkInfo> option;
  late MonthPageController controller;
  MonthHourStatistics? statistics;
  Map<DateDay, WorkInfo> marks = {};
  late DateMonth month;
  List<WorkInfo> workInfoList = [];

  @override
  void onInit() {
    DateTime _now = DateTime.now();
    month = DateMonth(_now.year, _now.day > 25 ? _now.month + 1 : _now.month);
    option = MonthOption<WorkInfo>(
      currentDay: DateDay.now(),
      currentMonth: month,
      enableMultiple: false,
    );
    super.onInit();
  }

  void changeMonth(DateMonth month) async{
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

  void getWorkInfo(DateMonth _month) {
    month = _month;
    update();
    BmobNetHelper.workInfoList(_month).then((value) {
      marks = value;
      controller
        ..setMarks(marks)
        ..reLoad();
    });

    BmobNetHelper.getHourStatistics(_month).then((value) {
      statistics = value;
      update();
    });
  }

  void getStatistics(DateDay _day) {
    if (_day.day > 25) {}
  }
}
