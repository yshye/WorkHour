import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:oktoast/oktoast.dart';
import 'package:work_hour/widgets/bottom_sheet_dialog.dart';

/// 日期选择
class DayPickerDialog extends StatefulWidget {
  final String? title;
  final DateTime day;
  final DateTime? maxDay;
  final DateTime? minDay;
  final List<DateTime>? enableDays;

  const DayPickerDialog({
    Key? key,
    this.title,
    required this.day,
    this.maxDay,
    this.minDay,
    this.enableDays = const [],
  }) : super(key: key);

  @override
  _DayPickerDialogState createState() => _DayPickerDialogState();
}

class _DayPickerDialogState extends State<DayPickerDialog> {
  late DateDay _day;

  @override
  void initState() {
    _day = DateDay.dateTime(widget.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetDialog(
      title: Text(widget.title ?? '选择日期',
          style: const TextStyle(fontSize: 18, color: Color(0xff63728f))),
      height: context.width,
      padding: const EdgeInsets.all(8),
      children: [
        MonthPageView<String>(
          MonthOption(
            enableContinuous: false,
            maxDay:
                widget.maxDay != null ? DateDay.dateTime(widget.maxDay!) : null,
            minDay:
                widget.minDay != null ? DateDay.dateTime(widget.minDay!) : null,
            enableMultiple: false,
            currentDay: _day,
            enableDays:
                widget.enableDays?.map((e) => DateDay.dateTime(e)).toList(),
          ),
          width: context.width - 40,
          padding: const EdgeInsets.only(left: 5, right: 5),
          scrollDirection: Axis.horizontal,
          showWeekHead: true,
          onDaySelected: (day, _, enable) {
            if (enable) {
              _day = day;
              Get.back(result: _day.time);
            } else {
              showToast('${day.toString()}不是可选日期！',
                  textStyle: const TextStyle(color: Colors.red));
            }
          },
        )
      ],
      onClose: () => Get.back(result: null),
      onOk: () {
        bool enable = (widget.minDay == null ||
                DateDay.dateTime(widget.minDay!) <= _day) &&
            (widget.maxDay == null ||
                DateDay.dateTime(widget.maxDay!) >= _day) &&
            (widget.enableDays == null ||
                widget.enableDays!
                    .any((element) => DateDay.dateTime(element) == _day));
        if (enable) {
          Get.back(result: _day.time);
        } else {
          showToast('请选择一个可用日期！',
              textStyle: const TextStyle(color: Colors.red));
        }
      },
    );
  }
}

Future<DateTime?> showDayDialog(
  BuildContext context,
  DateTime selectedDay, {
  String? title,
  DateTime? minDay,
  DateTime? maxDay,
  List<DateTime>? enableDays,
}) async {
  return await showModalBottomSheet<DateTime>(
    context: context,
    builder: (_) => DayPickerDialog(
      title: title,
      day: selectedDay,
      minDay: minDay,
      maxDay: maxDay,
      enableDays: enableDays,
    ),
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
  );
}
