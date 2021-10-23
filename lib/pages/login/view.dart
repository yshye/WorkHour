import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_hour/common/hues.dart';
import 'package:work_hour/widgets/material_button_cell.dart';
import 'package:work_hour/widgets/mini_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LoginLogic());

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background/logo_background.png'),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 120, bottom: 40),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/logo/logo_279_98.png',
                          height: 45, width: 94),
                      const SizedBox(height: 5),
                      const Text(
                        '专注 · 极致 · 口碑 · 快',
                        style: TextStyle(color: Color(0xff6f7689), fontSize: 9),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 55, right: 55),
                child: Column(
                  children: <Widget>[
                    MiniTextField(
                      controller: logic.usernameController,
                      icon: SvgPicture.asset(
                        'assets/svg/account_name.svg',
                        color: const Color(0xff787878),
                        width: 17,
                        height: 17,
                      ),
                      keyboardType: TextInputType.phone,
                      hintText: '请输入工号',
                      onClear: () {
                        logic.passwordController.text = '';
                      },
                      hintTextStyle: const TextStyle(
                          fontSize: 16, color: Color(0xffcbcbcb)),
                    ),
                    const SizedBox(height: 8),
                    MiniTextField(
                      controller: logic.passwordController,
                      icon: SvgPicture.asset(
                        'assets/svg/account_pwd.svg',
                        color: const Color(0xff787878),
                        width: 17,
                        height: 17,
                      ),
                      isInputPwd: true,
                      hintText: '请输入密码',
                      hintTextStyle: const TextStyle(
                          fontSize: 16, color: Color(0xffcbcbcb)),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 41),
                    MaterialButtonCell(
                      label: "登录",
                      onTap: logic.checkData,
                      radius: 45,
                      height: 50,
                      fontSize: 16,
                      textColor: Colors.white,
                      borderColor: Hues.appMain,
                      color: Hues.appMain,
                      miniWidth: double.infinity,
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        '忘记密码请联系管理员',
                        style: TextStyle(color: Color(0xff656d81)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
