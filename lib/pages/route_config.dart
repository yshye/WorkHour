import 'package:get/get.dart';
import 'package:work_hour/common/global.dart';
import 'package:work_hour/pages/holiday_setting/view.dart';
import 'package:work_hour/pages/month_hour/view.dart';

import 'login/view.dart';
import 'work_hour/view.dart';

class RouteConfig {
  static const String home = '/';
  static const String login = "/login";
  static const String workHour = "/work_hour";
  static const String monthHour = "/month_hour";
  static const String holidaySetting = "/holiday_setting";

  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () {
        if (Global.init().login) {
          return const MonthHourPage();
        }
        return const LoginPage();
      },
    ),
    GetPage(
      name: workHour,
      page: () => const WorkHourPage(),
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: monthHour,
      page: () => const MonthHourPage(),
    ),
    GetPage(
      name: holidaySetting,
      page: () => const HolidaySettingPage(),
    ),
  ];
}
