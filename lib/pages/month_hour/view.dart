import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:work_hour/bmob/net_helper.dart';
import 'package:work_hour/bmob/table/work_info.dart';
import 'package:work_hour/common/global.dart';
import 'package:work_hour/dialog/add_work_hour/view.dart';
import 'package:work_hour/pages/route_config.dart';
import 'package:work_hour/utils/pref_util.dart';

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
        backgroundColor: Colors.white,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
                    Container(
                      width: 2,
                      color: Colors.grey[300],
                      height: 20,
                    ),
                    Text(
                      ' 基础16，工作日️×1.5，周末×2，节假日×3。',
                      style: TextStyle(color: Colors.grey[400], fontSize: 16),
                    )
                  ],
                ),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text("工作日")),
                  DataColumn(label: Text("休息日"), numeric: true),
                  DataColumn(label: Text("节假日"), numeric: true),
                  DataColumn(label: Text("请假"), numeric: true),
                  DataColumn(label: Text("合计(¥)"), numeric: true),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(
                      logic.statistics.sum1.toString(),
                      style: const TextStyle(color: Colors.blueGrey),
                    )),
                    DataCell(Text(
                      logic.statistics.sum2.toString(),
                      style: const TextStyle(color: Colors.green),
                    )),
                    DataCell(Text(
                      logic.statistics.sum3.toString(),
                      style: const TextStyle(color: Colors.blue),
                    )),
                    DataCell(Text(
                      logic.statistics.leave.toString(),
                      style: const TextStyle(color: Colors.pink),
                    )),
                    DataCell(Text(
                      logic.statistics.price.toString(),
                      style: const TextStyle(color: Colors.orange),
                    )),
                  ]),
                ],
              ),
              Container(
                color: Colors.white,
                height: 10,
                width: double.infinity,
              ),
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
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  children: const [
                    TableRow(children: [
                      Text("日期",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16)),
                      Text("加班",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16)),
                      Text("请假",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16)),
                      Text("编辑",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16)),
                    ])
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

  Widget _buildWorkHourList(BuildContext context, MonthHourLogic logic) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        children: logic.workInfoList
            .map((day) => TableRow(children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          DateDay.dateTime(day.date!).toString(),
                        ),
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
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      day.overWorkHour > 0 ? day.overWorkHour.toString() : '',
                      style: const TextStyle(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      day.leaveHour > 0 ? day.leaveHour.toString() : '',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            MdiIcons.circleEditOutline,
                            color: Colors.blue,
                          ),
                          onPressed: () => editWorkHour(context, day, logic),
                        ),
                        IconButton(
                            icon: const Icon(
                              MdiIcons.close,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                _deleteWorkInfo(context, day, logic)),
                      ],
                    ),
                  ),
                ]))
            .toList(),
      ),
    );

    // return SingleChildScrollView(
    //   scrollDirection: Axis.vertical,
    //   child: DataTable(
    //     columns: const [
    //       DataColumn(label: Text("日期")),
    //       DataColumn(label: Text("加班"), numeric: true),
    //       DataColumn(label: Text("请假"), numeric: true),
    //       DataColumn(label: Text("编辑"), numeric: true),
    //     ],
    //     rows: logic.workInfoList
    //         .map((day) => DataRow(cells: [
    //       DataCell(
    //         Row(
    //           children: [
    //             Text(
    //               DateDay.dateTime(day.date!).toString(),
    //             ),
    //             Container(
    //               margin: const EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                 shape: BoxShape.rectangle,
    //                 borderRadius: BorderRadius.circular(4),
    //                 color: day.dateType == 1
    //                     ? Colors.green
    //                     : day.dateType == 2
    //                     ? Colors.blue
    //                     : Colors.blueGrey,
    //               ),
    //               child: Text(
    //                 day.dateType == 1
    //                     ? ' 休 '
    //                     : day.dateType == 2
    //                     ? ' 节 '
    //                     : ' 工 ',
    //                 style: const TextStyle(
    //                     color: Colors.white, fontSize: 12),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       DataCell(
    //         Text(
    //           day.overWorkHour > 0
    //               ? day.overWorkHour.toString()
    //               : '',
    //           style: const TextStyle(color: Colors.green),
    //         ),
    //       ),
    //       DataCell(Text(
    //         day.leaveHour > 0
    //             ? day.leaveHour.toString()
    //             : '',
    //         style: const TextStyle(color: Colors.red),
    //       )),
    //       DataCell(
    //         Row(
    //           children: [
    //             IconButton(
    //               icon: const Icon(
    //                 MdiIcons.circleEditOutline,
    //                 color: Colors.blue,
    //               ),
    //               onPressed: () =>
    //                   editWorkHour(context, day, logic),
    //             ),
    //             IconButton(
    //                 icon: const Icon(
    //                   MdiIcons.close,
    //                   color: Colors.red,
    //                 ),
    //                 onPressed: () => _deleteWorkInfo(
    //                     context, day, logic)),
    //           ],
    //         ),
    //       ),
    //     ]))
    //         .toList(),
    //   ),
    // );
  }

  void editWorkHour(
      BuildContext context, WorkInfo day, MonthHourLogic logic) async {
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
        showCupertinoDialog(
            context: context,
            builder: (_) {
              return CupertinoAlertDialog(
                title: const Text(
                  "⚠️ 警告",
                  style: TextStyle(color: Colors.red),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${info.dateStr}的记录已经存在，不可重新添加！"),
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('知道了'),
                  ),
                ],
              );
            });
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
  Future<void> _deleteWorkInfo(
      BuildContext context, WorkInfo day, MonthHourLogic logic) async {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text(
            "⚠️ 警告",
            style: TextStyle(color: Colors.red),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("确认删除${day.date.toString().substring(0, 11)}的记录？"),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Get.back();
              },
              child: const Text('取消'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                var success = await BmobNetHelper.deleteWorkInfo(day.objectId!);
                if (success) {
                  showToast("删除成功！");
                  logic.changeMonth(logic.month);
                  Get.back();
                } else {
                  showToast(
                    '删除失败！',
                    textStyle: const TextStyle(
                      color: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                '确认',
              ),
            )
          ],
        );
      },
    );
  }
}
