import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:work_hour/bmob/tables/user.dart';
import 'package:work_hour/bmob/tables/work_info.dart';
import 'package:work_hour/dialog/add_work_hour/view.dart';
import 'package:work_hour/dialog/alert_dialog.dart';
import 'package:work_hour/pages/route_config.dart';
import 'package:work_hour/utils/pref_util.dart';

import 'logic.dart';
import 'package:mini_calendar/mini_calendar.dart';

class MonthHourPage extends StatelessWidget {
  final TextStyle titleStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  const MonthHourPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MonthHourLogic());

    return Scaffold(
      appBar: AppBar(
        leading: prefUtil.user.username == '27017'
            ? IconButton(
                onPressed: () {
                  Get.toNamed(RouteConfig.holidaySetting);
                },
                color: Colors.blue,
                icon: const Icon(MdiIcons.tableSettings),
              )
            : null,
        title: GetBuilder<MonthHourLogic>(
          init: logic,
          builder: (logic) {
            return defaultBuildMonthHead(
              context,
              logic.month,
              onLast: logic.last,
              onNext: logic.next,
            );
          },
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              prefUtil.login = false;
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 15, bottom: 5),
                child: Text(
                  ' ????????????',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Container(width: 2, color: Colors.grey[300], height: 18),
                    Text(
                      '  ??????16?????????????????1.5???????????2??????????????3???',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    )
                  ],
                ),
              ),
              _buildStatistics(titleStyle, logic),
              Container(
                  color: Colors.white, height: 15, width: double.infinity),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                child: Text(
                  ' ????????????',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Table(
                  children: [
                    TableRow(children: [
                      Text("??????",
                          textAlign: TextAlign.center, style: titleStyle),
                      Text("??????(h)",
                          textAlign: TextAlign.center, style: titleStyle),
                      Text("??????(h)",
                          textAlign: TextAlign.center, style: titleStyle),
                      Text("??????",
                          textAlign: TextAlign.center, style: titleStyle),
                    ]),
                    const TableRow(
                        children: [Divider(), Divider(), Divider(), Divider()]),
                  ],
                ),
              ),
              Expanded(child: _buildWorkHourList(context, logic))
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editWorkHour(
              context,
              WorkInfoTable(
                username: prefUtil.user.username,
                dateType: 0,
                user: prefUtil.user,
                date: DateTime.now(),
              ),
              logic);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Padding _buildStatistics(TextStyle titleStyle, MonthHourLogic logic) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
      child: Table(
        children: [
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("?????????\n(h)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("?????????\n(h)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("?????????\n(h)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("??????\n(h)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("??????\n(??)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
          ]),
          const TableRow(children: [
            Divider(height: 1),
            Divider(height: 1),
            Divider(height: 1),
            Divider(height: 1),
            Divider(height: 1),
          ]),
          TableRow(children: [
            Container(
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(logic.statistics.weekdays.toString(),
                  style: const TextStyle(color: Colors.blueGrey)),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(logic.statistics.weekend.toString(),
                  style: const TextStyle(color: Colors.green)),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(logic.statistics.holiday.toString(),
                  style: const TextStyle(color: Colors.blue)),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(logic.statistics.leave.toString(),
                  style: const TextStyle(color: Colors.pink)),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(logic.statistics.price.toString(),
                  style: const TextStyle(color: Colors.orange)),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildWorkHourList(BuildContext context, MonthHourLogic logic) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        children: logic.infoList
            .map((day) => TableRow(children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                            color: day.dateType == 1
                                ? Colors.green
                                : day.dateType == 2
                                    ? Colors.blue
                                    : Colors.blueGrey,
                          ),
                          child: Text(
                            day.dateType == 1
                                ? ' ??? '
                                : day.dateType == 2
                                    ? ' ??? '
                                    : ' ??? ',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Text(
                          day.dateStr.substring(5),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      day.overWorkHour > 0 ? day.overWorkHour.toString() : '???',
                      style: const TextStyle(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      day.leaveHour > 0 ? day.leaveHour.toString() : '???',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(MdiIcons.circleEditOutline,
                                color: Colors.blue),
                            onPressed: () => editWorkHour(context, day, logic),
                            padding: EdgeInsets.zero,
                          ),
                          IconButton(
                            icon: const Icon(MdiIcons.close, color: Colors.red),
                            onPressed: () =>
                                _deleteWorkInfo(context, day, logic),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))
            .toList(),
      ),
    );
  }

  Future<void> editWorkHour(
      BuildContext context, WorkInfoTable day, MonthHourLogic logic) async {
    var info = await showWorkHourDialog(context, day);
    if (info != null) {
      L.i(info.toJson());
      if (info.objectId != null) {
        var value = await info.update();
        if (value) {
          showToast('???????????????');
          logic.changeMonth(logic.month);
        } else {
          showToast("???????????????");
        }
        return;
      }
      if (logic.infoList.any((element) => element.dateStr == info.dateStr)) {
        showMessageDialog(
          context,
          title: "?????? ??????",
          message: "${info.dateStr}?????????????????????????????????????????????",
          titleStyle: const TextStyle(color: Colors.red),
        );
        return;
      }
      var value = await info.install();
      if (value) {
        showToast('???????????????');
        logic.changeMonth(logic.month);
      } else {
        showToast("???????????????");
      }
    }
  }

  /// ??????????????????
  Future<void> _deleteWorkInfo(
      BuildContext context, WorkInfoTable day, MonthHourLogic logic) async {
    var flag = await showOkDialog(
      context,
      title: "?????? ??????",
      titleStyle: const TextStyle(color: Colors.red),
      message: "????????????${day.dateStr}????????????",
    );
    if (flag == 1) {
      var success = await day.delete();
      if (success) {
        showToast("???????????????");
        logic.changeMonth(logic.month);
        Get.back();
      } else {
        showToast(
          '???????????????',
          textStyle: const TextStyle(color: Colors.red),
        );
      }
    }
  }
}
