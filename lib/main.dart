import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_bmob/mini_bmob.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:work_hour/pages/route_config.dart';
import 'utils/pref_util.dart';

void main() async {
  await PrefUtil.init();
  BmobConfig.init(
    '7a8b44edc6bbf3a56e2e7f3f105485a2',
    'acadad3c7f4b9c6a86b842bc6cd4c80f',
    masterKey: '0e1d5a4a090e9cba9be2400e30aacdc7',
    printError: (log, _) => L.e(log),
    printResponse: (log, _) => L.d(log),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        getPages: RouteConfig.getPages,
        initialRoute: RouteConfig.home,
      ),
    );
  }
}
