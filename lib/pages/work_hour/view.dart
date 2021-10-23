import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:work_hour/bmob/table/work_info.dart';
import 'package:work_hour/common/global.dart';
import 'package:work_hour/pages/route_config.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:work_hour/widgets/day_info_widget.dart';

import 'logic.dart';

class WorkHourPage extends StatelessWidget {
  const WorkHourPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(WorkHourLogic());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Work Hour"),
        actions: [
          IconButton(
            onPressed: () {
              Global.init().login = false;
              Get.offAndToNamed(RouteConfig.login);
            },
            icon: const Icon(Icons.exit_to_app),
            color: Colors.red,
          )
        ],
      ),
      body: Column(
        children: [
          GetBuilder<WorkHourLogic>(
            init: logic,
            builder: (logic) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("工作日"), numeric: true),
                    DataColumn(label: Text("休息日"), numeric: true),
                    DataColumn(label: Text("节假日"), numeric: true),
                    DataColumn(label: Text("请假"), numeric: true),
                    DataColumn(label: Text("合计"), numeric: true),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        logic.statistics?.sum1.toString() ?? '',
                        style: const TextStyle(color: Colors.green),
                      )),
                      DataCell(Text(
                        logic.statistics?.sum2.toString() ?? '',
                        style: const TextStyle(color: Colors.green),
                      )),
                      DataCell(Text(
                        logic.statistics?.sum3.toString() ?? '',
                        style: const TextStyle(color: Colors.green),
                      )),
                      DataCell(Text(
                        logic.statistics?.leave.toString() ?? '',
                        style: const TextStyle(color: Colors.red),
                      )),
                      DataCell(Text(logic.statistics?.price.toString() ?? '')),
                    ]),
                  ],
                ),
              );
            },
          ),
          MonthPageView<WorkInfo>(
            logic.option,
            onCreated: (controller) {
              logic.controller = controller;
              logic.getWorkInfo(logic.option.currentMonth!);
            },
            onDaySelected: (day, workInfo, enable) {
              L.d("${day.toString()};${workInfo?.toJson()};$enable");
              logic.update();
            },
            onMonthChange: (_month) {
              logic.getWorkInfo(_month);
            },
            buildMark: (_, day, data) {
              if (data == null) return Container();
              return Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (data.leaveHour > 0) ...{
                      const Icon(MdiIcons.circle, color: Colors.red, size: 8),
                      const SizedBox(width: 3),
                    },
                    if (data.overWorkHour > 0) ...{
                      const Icon(MdiIcons.circle, color: Colors.blue, size: 8)
                    }
                  ],
                ),
              );
            },
          ),
          GetBuilder<WorkHourLogic>(
            init: logic,
            builder: (logic) {
              return DayInfoWidget(logic.option.currentDay!,
                  info: logic.marks[logic.option.currentDay]);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
