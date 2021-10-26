import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showMessageDialog(BuildContext context,
    {required String title,
    required String message,
    TextStyle? titleStyle,
    String backLabel = "知道了"}) {
  showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(title, style: titleStyle),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: Get.back,
              isDefaultAction: true,
              child: Text(backLabel),
            ),
          ],
        );
      });
}

Future<int?> showOkDialog(
  BuildContext context, {
  required String title,
  required String message,
  TextStyle? titleStyle,
  String cancelLabel = '取消',
  String okLabel = "确认",
}) async {
  return await showCupertinoDialog<int>(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: Text(title, style: titleStyle),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(result: -1),
            child: Text(cancelLabel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Get.back(result: 1),
            child: Text(okLabel),
          )
        ],
      );
    },
  );
}
