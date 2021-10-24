import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_hour/bmob/table/work_info.dart';

import 'logic.dart';

class AddWorkHourWidget extends StatelessWidget {
  final WorkInfo _info;
  const AddWorkHourWidget(this._info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddWorkHourLogic());
    logic.info = _info;

    return Container();
  }
}
