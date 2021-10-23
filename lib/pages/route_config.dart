import 'package:get/get.dart';
import 'package:work_hour/common/global.dart';

import 'login/view.dart';
import 'work_hour/view.dart';

class RouteConfig {
  static const String home = '/';
  static const String login = "/login";
  static const String workHour = "/work_hour";

  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () {
        if (Global.init().login) {
          return const WorkHourPage();
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
  ];
}
