import 'package:get/get.dart';
import 'package:work_hour/pages/holiday_setting/view.dart';
import 'package:work_hour/pages/month_hour/view.dart';
import 'package:work_hour/utils/pref_util.dart';

import 'login/view.dart';

class RouteConfig {
  static const String home = '/';
  static const String login = "/login";
  static const String monthHour = "/month_hour";
  static const String holidaySetting = "/holiday_setting";

  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () {
        if (prefUtil.login) {
          return const MonthHourPage();
        }
        return LoginPage();
      },
    ),
    GetPage(
      name: login,
      page: () => LoginPage(),
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
