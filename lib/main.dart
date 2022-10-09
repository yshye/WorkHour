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
    'a2e6af01ccc043d4ab8ef2ce308741b1',
    'f5d2b1d4043834879b17214096760a91',
    masterKey: 'd6e51f0c140e6528f25134424a79103c',
    host: "https://api2.bmobapp.com",
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
