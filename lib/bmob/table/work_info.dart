class WorkInfo {
  String? username;

  /// 考勤日类型：0-工作日，1-周末，2-法定节假日
  int dateType;
  DateTime? date;
  DateTime? beginTime;
  DateTime? endTime;

  String get dateStr => date.toString().substring(0, 10);

  /// 加班工时
  late num overWorkHour;

  /// 请假工时
  late num leaveHour;

  String? objectId;

  WorkInfo({
    this.username,
    this.dateType = 0,
    this.date,
    this.beginTime,
    this.endTime,
    this.overWorkHour = 0,
    this.leaveHour = 0,
    this.objectId,
  });

  factory WorkInfo.fromJson(Map<String, dynamic> json) {
    return WorkInfo(
      date: DateTime.parse(json['date']['iso']),
      username: json['username'],
      dateType: json['dateType'],
      overWorkHour: json['overWorkHour'] ?? 0,
      leaveHour: json['leaveHour'] ?? 0,
      objectId: json['objectId'],
      beginTime: json.containsKey('beginTime')
          ? DateTime.tryParse(json['beginTime']['iso'])
          : null,
      endTime: json.containsKey('endTime')
          ? DateTime.tryParse(json['endTime']['iso'])
          : null,
    );
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
        "date": {"__type": "Date", "iso": dateStr + " 08:00:00"},
        if (beginTime != null) ...{
          "beginTime": {
            "__type": "Date",
            "iso": beginTime?.toIso8601String().replaceAll("T", ' ')
          },
        },
        if (endTime != null) ...{
          "endTime": {
            "__type": "Date",
            "iso": endTime?.toIso8601String().replaceAll("T", ' ')
          },
        },
        "overWorkHour": overWorkHour,
        "leaveHour": leaveHour,
      };
}
