import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:work_hour/bmob/tables/work_info.dart';

class AddWorkHourLogic extends GetxController {
  late WorkInfoTable _workInfo;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController leaveController = TextEditingController();
  final TextEditingController overtimeController = TextEditingController();

  set workInfo(WorkInfoTable info) {
    _workInfo = info;
    dateController.text = info.date?.toString().substring(0, 11) ?? '';
    leaveController.text = info.leaveHour > 0 ? info.leaveHour.toString() : '';
    overtimeController.text =
        info.overWorkHour > 0 ? info.overWorkHour.toString() : '';
  }

  WorkInfoTable get workInfo => _workInfo;

  @override
  void onClose() {
    super.onClose();
    dateController.dispose();
    leaveController.dispose();
    overtimeController.dispose();
  }
}
