import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:work_hour/bmob/table/work_info.dart';

class DayInfoWidget extends StatelessWidget {
  final DateDay day;
  final WorkInfo? info;

  const DayInfoWidget(this.day, {Key? key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(day.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          )),
          const Divider(height: 1),
          Row(children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              child: Text(
                info == null
                    ? '未\n记\n录'
                    : info!.dateType == 1
                        ? '休\n息\n日'
                        : info!.dateType == 2
                            ? '节\n假\n日'
                            : '工\n作\n日',
                style: TextStyle(
                    color: info == null
                        ? null
                        : info!.dateType == 1
                            ? Colors.black45
                            : info!.dateType == 2
                                ? Colors.red[300]
                                : Colors.blue[300],
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "请假(H)",
                    style: TextStyle(fontSize: 16, color: Colors.red[300]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    info?.leaveHour.toString() ?? '',
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "加班(H)",
                    style: TextStyle(fontSize: 16, color: Colors.green[300]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    info?.overWorkHour.toString() ?? '',
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
