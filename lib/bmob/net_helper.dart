import 'package:dio/dio.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:work_hour/bmob/bmob.dart';
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
          // "X-Bmob-Master-Key": Bmob.masterKey,
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
              '{"date":{"\$gt":{"__type": "Date","iso": "${_begin.toString()} 00:00:00"},"\$lt":{"__type": "Date","iso": "${_end.toString()} 00:00:00"}},'
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

  static Future<List<WorkInfo>> workHourList(DateMonth month) async{
    try{
      DateDay _begin = DateDay(month.year, month.month - 1, 26);
      DateDay _end = DateDay(month.year, month.month, 25);
      var response = await dio.get(
        "/1/classes/work_infos",
        queryParameters: {
          'where':
          '{"date":{"\$gt":{"__type": "Date","iso": "${_begin.toString()} 00:00:00"},"\$lt":{"__type": "Date","iso": "${_end.toString()} 00:00:00"}},'
              '"username":"${Global.init().username}"}'
        },
      );
      List list = response.data['results'];
      return list.map((e) => WorkInfo.fromJson(e)).toList();
    }on DioError catch(e){
      L.e(e);
    }
    return [];
  }

  static Future<MonthHourStatistics> getHourStatistics(DateMonth month) async {
    try {
      DateDay _begin = DateDay(month.year, month.month - 1, 26);
      DateDay _end = DateDay(month.year, month.month, 25);
      var response = await dio.get(
        "/1/classes/work_infos",
        queryParameters: {
          'where':
              '{"date":{"\$gt":{"__type": "Date","iso": "${_begin.toString()} 00:00:00"},"\$lt":{"__type": "Date","iso": "${_end.toString()} 00:00:00"}},'
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
}
