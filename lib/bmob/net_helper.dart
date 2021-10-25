import 'package:dio/dio.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:work_hour/bmob/bmob.dart';
import 'package:work_hour/bmob/table/holiday.dart';
import 'package:work_hour/bmob/table/work_info.dart';
import 'package:work_hour/common/global.dart';
import 'package:work_hour/pages/month_hour/model.dart';

import 'table/user.dart';

class BmobNetHelper {
  static Dio? _dio;

  static Dio get dio {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: "https://api2.bmob.cn",
        contentType: Headers.jsonContentType,
        headers: {
          "X-Bmob-Application-Id": Bmob.appId,
          "X-Bmob-REST-API-Key": Bmob.apiKey,
          "X-Bmob-Master-Key": Bmob.masterKey,
        },
        connectTimeout: 3000,
        receiveTimeout: 10000,
        sendTimeout: 3000,
        responseType: ResponseType.json,
      );
      _dio = Dio(options);
    }
    return _dio!;
  }

  BmobNetHelper._();

  static Future<BmobUser?> login(String username, String pwd) async {
    try {
      var date = await dio.get(
        "/1/login",
        queryParameters: {
          'username': username,
          'password': pwd,
        },
      );
      return BmobUser.fromJson(date.data);
    } on DioError catch (e) {
      L.e(e);
    }
    return null;
  }

  static Future<Map<DateDay, WorkInfo>> workInfoList(DateMonth month) async {
    try {
      DateDay _begin = DateDay(month.year, month.month - 2, 26);
      DateDay _end = DateDay(month.year, month.month + 1, 25);
      var response = await dio.get(
        "/1/classes/work_infos",
        queryParameters: {
          'where':
              '{"date":{"\$gt":{"__type": "Date","iso": "${_begin.toString()} 00:00:00"},"\$lt":{"__type": "Date","iso": "${_end.toString()} 23:59:59"}},'
                  '"username":"${Global.init().username}"}'
        },
      );
      List list = response.data['results'];
      List<WorkInfo> infos = list.map((e) => WorkInfo.fromJson(e)).toList();
      L.d(infos.map((e) => e.toJson()));
      return {for (var item in infos) DateDay.dateTime(item.date!): item};
    } on DioError catch (e) {
      L.e(e);
    }
    return {};
  }

  static Future<List<WorkInfo>> workHourList(DateMonth month) async {
    try {
      DateDay _begin = DateDay(month.year, month.month - 1, 26);
      DateDay _end = DateDay(month.year, month.month, 25);
      var response = await dio.get(
        "/1/classes/work_infos",
        queryParameters: {
          'where':
              '{"date":{"\$gt":{"__type": "Date","iso": "${_begin.toString()} 00:00:00"},"\$lt":{"__type": "Date","iso": "${_end.toString()} 23:59:59"}},'
                  '"username":"${Global.init().username}"}',
          'order':'-date'
        },
      );
      List list = response.data['results'];
      return list.map((e) => WorkInfo.fromJson(e)).toList();
    } on DioError catch (e) {
      L.e(e);
    }
    return [];
  }

  static Future<bool> deleteWorkInfo(String objectId) async {
    try {
      var response = await dio.delete("/1/classes/work_infos/$objectId");
      return response.data['msg'] == 'ok';
    } on DioError catch (e) {
      L.e(e);
    }
    return false;
  }

  static Future<bool> addWorkInfo(WorkInfo info) async {
    try {
      L.i(info.toCreate());
      var response = await dio.post("/1/classes/work_infos",data: info.toCreate());
      Map<String,dynamic> data = response.data;
      if(data.containsKey('objectId')){
        return true;
      }
    } on DioError catch (e) {
      L.e(e);
    }
    return false;
  }

  static Future<bool> changeWorkInfo(WorkInfo info) async{
    try {
      L.d("/1/classes/work_infos/${info.objectId}");
      L.d(info.toCreate());
      var response = await dio.put("/1/classes/work_infos/${info.objectId}",data: info.toCreate());
      Map<String,dynamic> data = response.data;
      if(data.containsKey('updatedAt')){
        return true;
      }
    } on DioError catch (e) {
      L.e(e);
    }
    return false;
  }

  static Future<MonthHourStatistics> getHourStatistics(DateMonth month) async {
    try {
      DateDay _begin = DateDay(month.year, month.month - 1, 26);
      DateDay _end = DateDay(month.year, month.month, 25);
      var response = await dio.get(
        "/1/classes/work_infos",
        queryParameters: {
          'where':
              '{"date":{"\$gt":{"__type": "Date","iso": "${_begin.toString()} 00:00:00"},"\$lt":{"__type": "Date","iso": "${_end.toString()} 23:59:59"}},'
                  '"username":"${Global.init().username}"}',
          'sum': 'leaveHour,overWorkHour',
          'groupby': 'dateType',
          'groupcount': true,
        },
      );
      List list = response.data['results'];
      L.d(list);
      return MonthHourStatistics.fromJson(list);
    } on DioError catch (e) {
      L.e(e);
    }
    return MonthHourStatistics([]);
  }

  static Future<YearHoliday> getYearHoliday() async{

    return YearHoliday(oldHolidays: []);
  }
}
