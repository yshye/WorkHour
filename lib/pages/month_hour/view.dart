import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:work_hour/bmob/net_helper.dart';
import 'package:work_hour/bmob/table/work_info.dart';
import 'package:work_hour/common/global.dart';
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
        leading: prefUtil.user!.userName == '27017'
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
              Global
                  .init()
                  .login = false;
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
                  ' 月度统计',
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
                      '  基础16，工作日️×1.5，周末×2，节假日×3。',
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
                  ' 月度明细',
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
                      Text("日期",
                          textAlign: TextAlign.center, style: titleStyle),
                      Text("加班(h)",
                          textAlign: TextAlign.center, style: titleStyle),
                      Text("请假(h)",
                          textAlign: TextAlign.center, style: titleStyle),
                      Text("编辑",
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
              WorkInfo(
                username: prefUtil.user!.userName,
                dateType: 0,
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
              child: Text("工作日\n(h)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("休息日\n(h)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("节假日\n(h)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("请假\n(h)",
                  textAlign: TextAlign.center, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("合计\n(¥)",
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
              child: Text(logic.statistics.sum1.toString(),
                  style: const TextStyle(color: Colors.blueGrey)),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(logic.statistics.sum2.toString(),
                  style: const TextStyle(color: Colors.green)),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(logic.statistics.sum3.toString(),
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
        children: logic.workInfoList
            .map((day) =>
            TableRow(children: [
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
                            ? ' 休 '
                            : day.dateType == 2
                            ? ' 节 '
                            : ' 工 ',
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
                  day.overWorkHour > 0 ? day.overWorkHour.toString() : '—',
                  style: const TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  day.leaveHour > 0 ? day.leaveHour.toString() : '—',
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

  Future<void> editWorkHour(BuildContext context, WorkInfo day,
      MonthHourLogic logic) async {
    var info = await showWorkHourDialog(context, day);
    if (info != null) {
      L.i(info.toJson());
      if (info.objectId != null) {
        // 编辑
        BmobNetHelper.changeWorkInfo(info).then((value) {
          if (value) {
            showToast('修改成功！');
            logic.changeMonth(logic.month);
          } else {
            showToast("修改失败！");
          }
        });
        return;
      }
      if (logic.workInfoList
          .any((element) => element.dateStr == info.dateStr)) {
        showMessageDialog(
          context,
          title: "⚠️ 警告",
          message: "${info.dateStr}的记录已经存在，不可重新添加！",
          titleStyle: const TextStyle(color: Colors.red),
        );
        return;
      }
      BmobNetHelper.addWorkInfo(info).then((value) {
        if (value) {
          showToast('添加成功！');
          logic.changeMonth(logic.month);
        } else {
          showToast("添加失败！");
        }
      });
    }
  }

  /// 删除工时记录
  Future<void> _deleteWorkInfo(BuildContext context, WorkInfo day,
      MonthHourLogic logic) async {
    var flag = await showOkDialog(
      context,
      title: "⚠️ 警告",
      titleStyle: const TextStyle(color: Colors.red),
      message: "确认删除${day.dateStr}的记录？",
    );
    if (flag == 1) {
      var success = await BmobNetHelper.deleteWorkInfo(day.objectId!);
      if (success) {
        showToast("删除成功！");
        logic.changeMonth(logic.month);
        Get.back();
      } else {
        showToast(
          '删除失败！',
          textStyle: const TextStyle(color: Colors.red),
        );
      }
    }
  }
}
