import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'bottom_sheet_dialog.dart';
import 'tag_edit_cell.dart';

typedef BuildCheckChild<T> = Widget Function(BuildContext context, T t);

/// [onItemSelected] -1 代表无数据
Widget buildTagSelectCell<T>(
  BuildContext context,
  String tag, {
  IconData iconData = Icons.keyboard_arrow_down,
  Widget? icon,
  Color? iconColor = const Color(0xffbcbcbc),
  double? tagWidth = 100,
  String? hintText,
  double? fontSize = 16,
  double? miniHeight = 40,
  Color? tagColor = const Color(0xff63728f),
  TextEditingController? controller,
  TextInputType? inputType,
  InputDecoration? inputDecoration,
  List<T>? items,
  BuildCheckChild<T>? buildCheckChild,
  VoidCallback? onTap,
  bool required = false,
  bool isEdit = true,
  int valueMaxLines = 1,
  double paddingRight = 0.0,
  EdgeInsetsGeometry padding = const EdgeInsets.all(1),
  bool showLine = false,
  Color color = Colors.transparent,
  Widget? child,
  ValueChanged<int>? onItemSelected,
  double iconWidth = 40,
  TagCellStyle style = TagCellStyle.style2,
}) {
  return Material(
    color: color,
    child: Ink(
      child: InkWell(
        onTap: isEdit
            ? (onItemSelected == null
                ? onTap
                : () {
                    if (items == null || items.isEmpty) {
                      onItemSelected(-1);
                    }
                    showBottomPopup(context, '请选择$tag', items!,
                            buildCheckChild: buildCheckChild, autoHeight: true)
                        .then((index) {
                      if (index == null || index < 0) return;
                      onItemSelected(index);
                    });
                  })
            : null,
        child: Column(children: <Widget>[
          Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: tagWidth,
                    height: miniHeight ?? 40,
                    child: Row(
                      children: <Widget>[
                        required
                            ? const Icon(MdiIcons.multiplication,
                                size: 8, color: Colors.red)
                            : Container(width: 0),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            tag,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: tagColor,
                                height: 1.1,
                                fontSize: fontSize),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: child ??
                      TextField(
                        enabled: false,
                        enableInteractiveSelection: false,
                        controller: controller,
                        keyboardType: inputType ?? TextInputType.text,
                        textAlign: style == TagCellStyle.style1
                            ? TextAlign.start
                            : TextAlign.right,
                        decoration: inputDecoration ??
                            InputDecoration(
                              hintText: hintText ?? '请选择$tag',
                              hintStyle: TextStyle(
                                  fontSize: fontSize,
                                  height: 1.1,
                                  color: const Color(0xffd2d2d2)),
                              border: InputBorder.none,
                              labelStyle: TextStyle(fontSize: fontSize),
                            ),
                        style: TextStyle(height: 1.1, fontSize: fontSize),
                      ),
                ),
                const SizedBox(width: 5),
                Container(
                  width: isEdit ? iconWidth : 0,
                  alignment: Alignment.topRight,
                  child: isEdit
                      ? (icon ??
                          Icon(iconData, color: iconColor ?? Color(0xffbcbcbc)))
                      : Container(),
                ),
                SizedBox(width: paddingRight)
              ],
            ),
          ),
          showLine ? Divider(height: 0.5, color: Colors.grey[50]) : Container(),
        ]),
      ),
    ),
  );
}

Future<int?> showBottomPopup<T>(
    BuildContext context, String title, List<T> items,
    {String? message,
    BuildCheckChild<T>? buildCheckChild,
    double? height,
    bool autoHeight = false}) async {
  if (autoHeight && height == null) {
    if (items.length < 5) {
      height = 40 + items.length * MediaQuery.of(context).size.height * 4 / 45;
    }
  }
  return showCupertinoModalPopup<int>(
    context: context,
    builder: (ctx) => BottomSheetDialog(
      height: height ?? MediaQuery.of(context).size.height * 4 / 9,
      titleLeft: Container(),
      titleRight: CupertinoButton(
        child: const Icon(Icons.clear, color: Colors.grey),
        padding: const EdgeInsets.all(10),
        onPressed: () => Get.back(result: -1),
      ),
      title: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      children: items
          .map((item) => ListTile(
                title: buildCheckChild != null
                    ? buildCheckChild(ctx, item)
                    : Text(item.toString(),
                        style: const TextStyle(fontSize: 16)),
                onTap: () => Get.back(result: items.indexOf(item)),
              ))
          .toList(),
    ),
  );
}
