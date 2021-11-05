import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:work_hour/bmob/tables/user.dart';
import 'package:work_hour/pages/route_config.dart';
import 'package:work_hour/utils/pref_util.dart';

class LoginLogic extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    usernameController.text = prefUtil.username;
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
    UserTable _user = UserTable(
        username: usernameController.text, password: passwordController.text);
    var flag = await _user.login();
    if(!flag){
      showToast("账户或密码错误！");
      return;
    }
    prefUtil.username = _user.username!;
    prefUtil.login = true;
    Get.offAndToNamed(RouteConfig.monthHour);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
