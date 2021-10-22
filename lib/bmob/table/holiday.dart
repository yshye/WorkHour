import 'package:work_hour/bmob/bmob.dart';

class YearHoliday {
  List<Holiday>? oldHolidays;
  List<Holiday>? newHolidays;

  YearHoliday({this.oldHolidays}) {
    newHolidays = [...?oldHolidays];
  }

  List<Map<String, dynamic>> toDeleteJson() =>
      oldHolidays
          ?.map((e) => {
                "method": "DELETE",
                "path": "/1/classes/holidays/${e.objectId}",
                "token": Bmob.token,
                "body": {}
              })
          .toList() ??
      [];

  List<Map<String, dynamic>> toCreateJson() =>
      newHolidays
          ?.map((e) => {
                "method": "POST",
                "path": "/1/classes/holidays",
                "body": e.toCreate()
              })
          .toList() ??
      [];

  List<Map<String, dynamic>> toBatchJson() =>
      toDeleteJson()..addAll(toCreateJson());
}

class Holiday {
  DateTime? date;

  /// 类型：1-休息日，2-法定节假日
  int? type;

  String? objectId;

  Holiday({this.date, this.type, this.objectId});

  fromJson(Map<String, dynamic> json) {
    type = json['type'];
    date = json['date'];
    objectId = json['objectId'];
  }

  Map<String, dynamic> toCreate() => {
        "date": {"__type": "Date", "iso": date?.toIso8601String()},
        "type": type,
      };
}
