import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:work_hour/bmob/net_helper.dart';
import 'package:work_hour/common/global.dart';
import 'package:work_hour/pages/route_config.dart';

class LoginLogic extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    usernameController.text = Global.init().username ?? '';
    passwordController.text = Global.init().password ?? '';
    super.onInit();
  }

  void checkData() async {
    if (usernameController.text.isEmpty) {
      showToast("用户名不可为空!");
      return;
    }
    if (passwordController.text.isEmpty) {
      showToast("密码不可为空！");
      return;
    }
    var user = await BmobNetHelper.login(
        usernameController.text, passwordController.text);
    if (user == null) {
      showToast("账户或密码错误！");
      return;
    }
    Global.init().user = user;
    Global.init().login = true;
    Get.offAndToNamed(RouteConfig.monthHour);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
