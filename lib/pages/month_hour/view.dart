import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_hour/common/global.dart';
import 'package:work_hour/pages/route_config.dart';

import 'logic.dart';
import 'package:mini_calendar/mini_calendar.dart';

class MonthHourPage extends StatelessWidget {
  const MonthHourPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MonthHourLogic());

    return Scaffold(
      appBar: AppBar(
        title: defaultBuildMonthHead(
          context,
          logic.month,
          onLast: logic.last,
          onNext: logic.next,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Global.init().login = false;
              Get.offAndToNamed(RouteConfig.login);
            },
            icon: const Icon(Icons.exit_to_app_sharp),
            color: Colors.pink,
          )
        ],
      ),
      body: GetBuilder<MonthHourLogic>(
        init: logic,
        builder: (logic) {
          return Column(
            children: [
              SingleChildScrollView(
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
                        logic.statistics.sum1.toString(),
                        style: const TextStyle(color: Colors.green),
                      )),
                      DataCell(Text(
                        logic.statistics.sum2.toString() ,
                        style: const TextStyle(color: Colors.green),
                      )),
                      DataCell(Text(
                        logic.statistics.sum3.toString(),
                        style: const TextStyle(color: Colors.green),
                      )),
                      DataCell(Text(
                        logic.statistics.leave.toString(),
                        style: const TextStyle(color: Colors.red),
                      )),
                      DataCell(Text(logic.statistics.price.toString())),
                    ]),
                  ],
                ),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text("日期")),
                  DataColumn(label: Text("加班"), numeric: true),
                  DataColumn(label: Text("请假"), numeric: true),
                ],
                rows: logic.workInfoList
                    .map((day) => DataRow(cells: [
                          DataCell(Text(
                            DateDay.dateTime(day.date!).toString(),
                            style: const TextStyle(color: Colors.green),
                          )),
                          DataCell(Text(
                            day.overWorkHour.toString(),
                            style: const TextStyle(color: Colors.green),
                          )),
                          DataCell(Text(
                            day.leaveHour.toString(),
                            style: const TextStyle(color: Colors.red),
                          )),
                        ]))
                    .toList(),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
