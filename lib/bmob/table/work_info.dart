import 'package:flutter/foundation.dart';
import 'package:mini_calendar/mini_calendar.dart';

class WorkInfo {
  String? username;

  /// 考勤日类型：0-工作日，1-周末，2-法定节假日
  int? dateType;
  DateTime? date;
  DateTime? beginTime;
  DateTime? endTime;

  /// 加班工时
  late num overWorkHour;

  /// 请假工时
  late num leaveHour;

  String? objectId;

  WorkInfo({
    this.username,
    this.dateType,
    this.date,
    this.beginTime,
    this.endTime,
    this.overWorkHour = 0,
    this.leaveHour = 0,
    this.objectId,
  });

  WorkInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    dateType = json['dateType'];
    overWorkHour = json['overWorkHour'] ?? 0;
    leaveHour = json['leaveHour'] ?? 0;
    objectId = json['objectId'];
    if (json.containsKey('date')) {
      date = DateTime.tryParse(json['date']['iso']);
    }
    if (json.containsKey("beginTime")) {
      beginTime = DateTime.tryParse(json['beginTime']['iso']);
    }
    if (json.containsKey("endTime")) {
      endTime = DateTime.tryParse(json['endTime']['iso']);
    }
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'dateType': dateType,
        'overWorkHour': overWorkHour,
        'leaveHour': leaveHour,
        'date': date,
        'beginTime': beginTime,
        'endTime': endTime,
        'objectId': objectId,
      };

  /// 新增post或修改put的数据
  Map<String, dynamic> toCreate() => {
        "username": username,
        "dateType": dateType,
        "date": {"__type": "Date", "iso": date?.toIso8601String()},
        "beginTime": {"__type": "Date", "iso": beginTime?.toIso8601String()},
        "endTime": {"__type": "Date", "iso": endTime?.toIso8601String()},
        "overWorkHour": overWorkHour,
        "leaveHour": leaveHour,
      };
}
