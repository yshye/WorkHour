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
    'b29b32c1dd21890eb764bc87837f8378',
    'cabdb96816af918376e6b995f610c341',
    masterKey: '0f722971aae6e69907e684a175bcc2c6',
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
