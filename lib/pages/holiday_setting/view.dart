import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'logic.dart';

class HolidaySettingPage extends StatelessWidget {
  const HolidaySettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HolidaySettingLogic());

    return Scaffold(
      appBar: AppBar(
        title: const Text("节假日设置"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(MdiIcons.checkCircle))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(),
      ),
    );
  }
}
