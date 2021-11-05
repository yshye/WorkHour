import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_hour/bmob/tables/work_info.dart';
import 'package:work_hour/widgets/bottom_sheet_dialog.dart';
import 'package:work_hour/widgets/tag_edit_cell.dart';
import 'package:work_hour/widgets/tag_select_cell.dart';

import '../day_picker_dialog.dart';
import 'logic.dart';

class AddWorkHourComponent extends StatelessWidget {
  final WorkInfoTable _info;

  const AddWorkHourComponent(this._info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddWorkHourLogic());
    logic.workInfo = _info;

    return BottomSheetDialog(
      title: Text(_info.objectId == null ? '新增工时' : '修改工时',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      height: 300,
      children: <Widget>[
        buildTagSelectCell(
          context,
          '考勤日期',
          controller: logic.dateController,
          required: true,
          onTap: () => _selectDate(context, logic),
          isEdit: _info.objectId == null,
        ),
        buildTagSelectCell(
          context,
          '加班类型',
          isEdit: false,
          child: GetBuilder<AddWorkHourLogic>(
              init: logic,
              builder: (logic) {
                return CupertinoSegmentedControl(
                  onValueChanged: (int value) {
                    logic.workInfo.dateType = value;
                    logic.update();
                  },
                  children: const {
                    0: Text("工作日"),
                    1: Text("休息日"),
                    2: Text("节假日"),
                  },
                  groupValue: logic.workInfo.dateType,
                );
              }),
          required: true,
        ),
        EditCell(
          data: EditValueModel(
            tag: '  加班工时',
            hintText: '只能录入0.5h的倍数',
            controller: logic.overtimeController,
            fontSize: 16,
            maxLength: null,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            maxNum: 24,
            placesLength: 1,
            onlyNumValue: 5,
            suffix: 'h',
          ),
        ),
        EditCell(
          data: EditValueModel(
            tag: '  请假工时',
            hintText: '只能录入0.5h的倍数',
            controller: logic.leaveController,
            fontSize: 16,
            maxLength: null,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            maxNum: 24,
            placesLength: 1,
            onlyNumValue: 5,
            suffix: 'h',
          ),
        ),
      ],
      onOk: () {
        logic.workInfo.leaveHour =
            num.tryParse(logic.leaveController.text) ?? 0;
        logic.workInfo.overWorkHour =
            num.tryParse(logic.overtimeController.text) ?? 0;
        Get.back(result: logic.workInfo);
      },
    );
  }

  void _selectDate(BuildContext context, AddWorkHourLogic logic) async {
    var day = await showDayDialog(
        context, logic.workInfo.date,
        title: "选择考勤日期");
    if (day != null) {
      logic.workInfo.date = day;
      logic.dateController.text = day.toString().substring(0, 10);
    }
  }
}

Future<WorkInfoTable?> showWorkHourDialog(
    BuildContext context, WorkInfoTable info) async {
  return await showModalBottomSheet<WorkInfoTable>(
    context: context,
    builder: (_) => AddWorkHourComponent(info),
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
  );
}
