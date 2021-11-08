import 'package:dio/dio.dart';
import 'package:mini_bmob/mini_bmob.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:work_hour/bmob/tables/work_info.dart';
import 'package:work_hour/pages/month_hour/model.dart';


class BmobNetHelper {

  BmobNetHelper._();


  static Future<List<WorkInfoTable>> infoList(
      DateMonth month, String username) async {
    try {
      DateTime _begin = DateTime(month.year, month.month - 1, 26);
      DateTime _end = DateTime(month.year, month.month, 25, 23, 59, 59, 999);
      BmobWhereBuilder _where = BmobWhereBuilder();
      _where.whereBasic<DateTime>('date').gte(_begin).lte(_end);
      _where.whereBasic<String>('username').contain([username]);
      _where.order(['-date']);
      BmobSetResponse<WorkInfoTable> set =
          await BmobQueryHelper.query(
        WorkInfoTable(),
        (json) => WorkInfoTable().fromJson(json),
        where: _where,
      );
      return set.results;
    } on DioError catch (e) {
      L.e(e);
    }
    return [];
  }

  static Future<MonthHourStatistics> getHourStatistics(
      DateMonth month, String username) async {
    try {
      DateTime _begin = DateTime(month.year, month.month - 1, 26);
      DateTime _end = DateTime(month.year, month.month, 25, 23, 59, 59, 999);
      BmobWhereBuilder _where = BmobWhereBuilder();
      _where.whereBasic<DateTime>('date').gte(_begin).lte(_end);
      _where.whereBasic<String>('username').contain([username]);
      _where.sum(['leaveHour', 'overWorkHour']);
      _where.groupBy(fields: ['dateType']);
      BmobSetResponse<StatisticsItem> data = await BmobQueryHelper.query(
        WorkInfoTable(),
        (json) => StatisticsItem.fromJson(json),
        where: _where,
      );
      return MonthHourStatistics(data.results);
    } on DioError catch (e) {
      L.e(e);
    }
    return MonthHourStatistics([]);
  }
}
