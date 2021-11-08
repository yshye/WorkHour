import 'package:mini_bmob/mini_bmob.dart';
import 'package:work_hour/bmob/tables/user.dart';

class WorkInfoTable extends BmobTable {
  /// 考勤日期
  BmobDateTime? _date;

  set date(DateTime? value) => _date = BmobDateTime(value ?? DateTime.now());

  DateTime? get date => _date?.dateTime;

  String get dateStr => date.toString().substring(0, 10);

  /// 用户name
  String? username;

  /// 考勤日类型：0-工作日，1-周末，2-法定节假日
  late int dateType;

  /// 加班工时
  late num overWorkHour;

  /// 请假工时
  late num leaveHour;


  @override
  String getBmobTabName() => 'work_infos';

  WorkInfoTable({
    DateTime? date,
    this.username,
    this.dateType = 0,
    this.overWorkHour = 0,
    this.leaveHour = 0,
    UserTable? user,
  }) {
    _date = BmobDateTime(date ?? DateTime.now());
  }

  @override
  WorkInfoTable fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    _date = BmobDateTime.fromJson(json['date']);
    username = json['username'];
    dateType = json['dateType'];
    overWorkHour = json['overWorkHour'];
    leaveHour = json['leaveHour'];
    return this;
  }

  @override
  Map<String, dynamic> createJson() => {
        ...super.createJson(),
        'username': username,
        // 'user': user?.createJson(),
        'date': _date?.toJson(),
        'dateType': dateType,
        'overWorkHour': overWorkHour,
        'leaveHour': leaveHour,
      };
}
