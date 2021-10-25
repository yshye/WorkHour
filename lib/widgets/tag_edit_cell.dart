import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditCell extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double minHeight;
  final bool showCounter;
  final EditValueModel data;

  const EditCell(
      {Key? key,
      this.padding = const EdgeInsets.all(1),
      this.minHeight = 35,
      required this.data,
      this.showCounter = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: padding,
          color: data.color,
          child: data.tag2 == null
              ? _buildOneItem(
                  context,
                  showCounter: showCounter,
                  hintText: data.hintText,
                  valueColor: data.valueColor,
                  fontSize: data.fontSize,
                  tagWidth: data.tagWidth,
                  isEdit: data.isEdit,
                  required: data.required,
                  tag: data.tag,
                  tagColor: data.tagColor,
                  suffix: data.suffix,
                  controller: data.controller,
                  inputType: data.inputType,
                  child: data.child,
                  valueMaxLines: data.maxLines,
                  minHeight: minHeight,
                  maxLength: data.maxLength,
                  maxNum: data.maxNum,
                  placesLength: data.placesLength,
                  onlyNumValue: data.onlyNumValue,
                  style: data.style,
                  direction: data.direction,
                )
              : _buildTwoItem(
                  context,
                  fontSize: data.fontSize ?? 14,
                  suffix: data.suffix,
                  suffix2: data.suffix2,
                  valueMaxLines: data.maxLines,
                  valueColor: data.valueColor,
                  valueColor2: data.valueColor2,
                  tagWidth: data.tagWidth,
                  tagWidth2: data.tagWidth2,
                  isEdit: data.isEdit,
                  isEdit2: data.isEdit2,
                  required: data.required,
                  required2: data.required2,
                  tag: data.tag,
                  tag2: data.tag2,
                  tagColor: data.tagColor,
                  tagColor2: data.tagColor2,
                  controller: data.controller,
                  controller2: data.controller2,
                  inputType: data.inputType,
                  inputType2: data.inputType2,
                  hintText: data.hintText,
                  hintText2: data.hintText2,
                  minHeight: minHeight,
                  maxLength: data.maxLength,
                  maxLength2: data.maxLength2,
                  maxNum: data.maxNum,
                  maxNum2: data.maxNum2,
                  placesLength2: data.placesLength2,
                  placesLength: data.placesLength,
                  onlyNumValue2: data.onlyNumValue2,
                  onlyNumValue: data.onlyNumValue,
                ),
        ),
        data.showLine
            ? Divider(height: 0.5, color: Colors.grey[50])
            : Container(height: 0),
      ],
    );
  }

  _buildTwoItem(
    BuildContext context, {
    String? tag,
    double? tagWidth = 90,
    String? tag2,
    double? tagWidth2 = 90,
    double? minHeight = 35,
    String? suffix,
    String? suffix2,
    Color? tagColor = Colors.grey,
    Color? tagColor2 = Colors.grey,
    Color? valueColor = Colors.black,
    Color? valueColor2 = Colors.black,
    FocusNode? focusNode,
    FocusNode? focusNode2,
    bool required = false,
    bool required2 = false,
    int? valueMaxLines = 1,
    int? maxLength,
    int? maxLength2,
    bool isEdit = true,
    bool isEdit2 = true,
    TextEditingController? controller,
    TextEditingController? controller2,
    ValueChanged<String>? onChange,
    ValueChanged<String>? onChange2,
    TextInputType? inputType = TextInputType.text,
    TextInputType? inputType2 = TextInputType.text,
    InputDecoration? inputDecoration,
    InputDecoration? inputDecoration2,
    String? hintText,
    String? hintText2,
    double fontSize = 14,
    num? maxNum,
    num? maxNum2,
    int? placesLength,
    int? onlyNumValue,
    int? placesLength2,
    int? onlyNumValue2,
  }) {
    return Flex(direction: Axis.horizontal, children: <Widget>[
      Container(
        width: tagWidth,
        height: minHeight,
        alignment: Alignment.topLeft,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
                  tag ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: tagColor, height: 1.1, fontSize: fontSize),
                ),
                flex: 1),
            required
                ? const Icon(MdiIcons.multiplication,
                    size: 8, color: Colors.red)
                : Container(),
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: TextField(
          maxLines: valueMaxLines,
          enabled: isEdit,
          focusNode: focusNode,
          enableInteractiveSelection: isEdit,
          controller: controller,
          // maxLengthEnforced: true,
          onChanged: onChange,
          keyboardType: inputType,
          maxLength: maxLength,
          inputFormatters: _getInputFormatter(
            inputType ?? TextInputType.text,
            maxLength: maxLength,
            maxNum: maxNum,
            placesLength: placesLength,
            onlyNumValue: onlyNumValue,
          ),
          decoration: inputDecoration ??
              InputDecoration(
                  hintText: hintText ?? '请填写$tag',
                  border: isEdit ? null : InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 3),
                  suffixStyle: const TextStyle(color: Colors.black87),
                  suffixText: suffix ?? ''),
          style: TextStyle(height: 1.1, fontSize: fontSize, color: valueColor),
        ),
      ),
      Container(
        width: tagWidth2,
        height: minHeight,
        padding: const EdgeInsets.only(left: 3),
        alignment: Alignment.topLeft,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
                  tag2 ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: tagColor2, height: 1.1),
                ),
                flex: 1),
            required2
                ? const Icon(MdiIcons.multiplication,
                    size: 8, color: Colors.red)
                : Container(),
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: TextField(
          maxLines: valueMaxLines,
          enabled: isEdit,
          focusNode: focusNode2,
          enableInteractiveSelection: isEdit,
          controller: controller2,
          // maxLengthEnforced: true,
          onChanged: onChange2,
          maxLength: maxLength2,
          keyboardType: inputType2 ?? TextInputType.text,
          inputFormatters: _getInputFormatter(
            inputType2 ?? TextInputType.text,
            maxLength: maxLength2,
            maxNum: maxNum2,
            placesLength: placesLength2,
            onlyNumValue: onlyNumValue2,
          ),
          decoration: inputDecoration2 ??
              InputDecoration(
                hintText: hintText2 ?? '请填写$tag2',
                border: isEdit2 ? null : InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 3),
                suffixText: suffix2 ?? '',
                suffixStyle: const TextStyle(color: Colors.black87),
              ),
          style: TextStyle(height: 1.1, fontSize: 14, color: valueColor2),
        ),
      ),
    ]);
  }

  _buildOneItem(
    BuildContext context, {
    String? tag,
    String? suffix,
    bool showCounter = true,
    double? tagWidth = 90,
    double? minHeight = 35,
    int? maxLength,
    Color? valueColor = Colors.black,
    Color? tagColor = Colors.grey,
    bool required = false,
    int? valueMaxLines = 1,
    bool? isEdit = true,
    FocusNode? focusNode,
    // KeyboardActionsConfig config,
    TextEditingController? controller,
    ValueChanged<String>? onChange,
    TextInputType? inputType = TextInputType.text,
    InputDecoration? inputDecoration,
    String? hintText,
    double? fontSize = 14,
    Widget? child,
    num? maxNum,
    int? placesLength,
    int? onlyNumValue,
    TagCellStyle? style = TagCellStyle.style2,
    Axis? direction = Axis.horizontal,
  }) {
    Widget _tagWidget = Container(
      width: tagWidth,
      height: minHeight,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          required
              ? const Icon(MdiIcons.multiplication, size: 8, color: Colors.red)
              : Container(),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              tag ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  TextStyle(color: tagColor, height: 1.1, fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
    Widget _contentWidget = child ??
        Container(
          alignment: Alignment.topLeft,
          child: TextField(
            maxLines: valueMaxLines,
            focusNode: focusNode,
            enabled: isEdit,
            enableInteractiveSelection: isEdit ?? false,
            // maxLengthEnforced: true,
            controller: controller,
            onChanged: onChange,
            keyboardType:
                (valueMaxLines != null && valueMaxLines > 1) ? null : inputType,
            maxLength: maxLength,
            textAlign:
                style == TagCellStyle.style1 ? TextAlign.left : TextAlign.right,
            inputFormatters: _getInputFormatter(inputType ?? TextInputType.text,
                maxLength: maxLength,
                maxNum: maxNum,
                onlyNumValue: onlyNumValue,
                placesLength: placesLength),
            textAlignVertical: TextAlignVertical.top,
            decoration: inputDecoration ??
                InputDecoration(
                    hintText: hintText ?? '请填写$tag',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 4),
                    labelStyle: TextStyle(fontSize: fontSize),
                    hintStyle: TextStyle(
                        fontSize: fontSize,
                        height: 1.1,
                        color: const Color(0xffd2d2d2)),
                    suffixText: suffix ?? '',
                    counterStyle: const TextStyle(color: Color(0xffd2d2d2)),
                    counterText: showCounter ? null : ''
//                focusedBorder:
//                    UnderlineInputBorder(borderSide: BorderSide(color: ThemeUtil.getPrimaryColor(context), width: 0.8)),
//                enabledBorder:
//                    UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 0.8)),
                    ),
            style:
                TextStyle(height: 1.1, fontSize: fontSize, color: valueColor),
          ),
        );

    return direction == Axis.horizontal
        ? Row(children: <Widget>[
            _tagWidget,
            Expanded(child: _contentWidget),
            const SizedBox(width: 5)
          ])
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                _tagWidget,
                const SizedBox(height: 5),
                _contentWidget
              ]);
  }
}

/// [placesLength] 小数位（[decimal]=true时生效）<br/>
/// [onlyNumValue] 固定小数位,范围 null || [1-9]且[placesLength]=1时可用
_getInputFormatter(TextInputType keyboardType,
    {int? maxLength, num? maxNum, int? placesLength, int? onlyNumValue}) {
  if (keyboardType == const TextInputType.numberWithOptions(decimal: true)) {
    return [
      UsNumberTextInputFormatter(
        max: maxNum,
        onlyNumValue: onlyNumValue,
        placesLength: placesLength,
        decimal: keyboardType ==
            const TextInputType.numberWithOptions(decimal: true),
      )
    ];
  } else if (keyboardType == TextInputType.number) {
    return [
      UsNumberTextInputFormatter(max: maxNum, decimal: false),
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength),
    ];
  } else if (keyboardType == TextInputType.phone) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength)
    ];
  }
  return null;
}

class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;
  bool decimal;
  num? max;

  /// 小数位（[decimal]=true时生效）
  int? placesLength;

  /// 固定小数位,范围 null || [1-9]且[placesLength]=1时可用，
  int? onlyNumValue;

  UsNumberTextInputFormatter(
      {this.max, this.decimal = true, this.placesLength, this.onlyNumValue})
      : assert(onlyNumValue == null || (onlyNumValue > 0 && onlyNumValue < 10));

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (decimal) {
      if (value == '.') {
        value = '0.';
      } else if (value != '' &&
          value != defaultDouble.toString() &&
          strToFloat(value, defaultDouble) == defaultDouble) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      } else {
        if (placesLength != null) {
          int index = value.indexOf('.');
          if (index > 0 && index + placesLength! < value.length) {
            if (placesLength == 1 && onlyNumValue != null) {
              value = "${value.substring(0, index + 1)}$onlyNumValue";
            } else {
              value = value.substring(0, index + placesLength! + 1);
            }
          }
        }
      }
    }
    if (max != null && value.isNotEmpty && num.parse(value) > max!) {
      value = '$max';
    }
    selectionIndex = value.length;
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class EditValueModel {
  /// 背景颜色
  Color? color;

  /// 标题
  String? tag;

  Color? tagColor;

  Color? tagColor2;

  /// 后缀
  String? suffix;

  /// 标签宽度
  double? tagWidth;

  /// 内容颜色
  Color? valueColor;

  FocusNode? focusNode;

  /// 提示文字
  String? hintText;

  /// 输入类型
  TextInputType? inputType;

  /// 最大行数
  int? maxLines;

  int? maxLength;

  int? maxLength2;

  num? maxNum;
  num? maxNum2;
  Axis? direction;

  int? placesLength;
  int? onlyNumValue;
  int? placesLength2;
  int? onlyNumValue2;
  double? fontSize;

  /// 内容更改回调
  ValueChanged<String>? onChange;

  /// 输入框
  InputDecoration? inputDecoration;

  /// 控制器
  TextEditingController? controller;
  String? tag2;
  String? suffix2;
  double? tagWidth2;
  String? hintText2;
  Color? valueColor2;
  TextInputType? inputType2;
  FocusNode? focusNode2;
  ValueChanged<String>? onChange2;
  InputDecoration? inputDecoration2;
  TextEditingController? controller2;
  bool required2;
  bool isEdit2;
  int? maxLines2;

  /// 是否显示下划线
  bool showLine;

  /// 是否编辑
  bool isEdit;

  /// 是否必填
  bool required;

  /// 自定义内容
  Widget? child;

  TagCellStyle? style;

  EditValueModel({
    this.tag,
    this.tag2,
    this.suffix,
    this.suffix2,
    this.tagWidth = 90,
    this.tagWidth2 = 90,
    this.hintText,
    this.hintText2,
    this.valueColor = Colors.black,
    this.valueColor2 = Colors.black,
    this.inputType = TextInputType.text,
    this.inputType2 = TextInputType.text,
    this.maxLines = 1,
    this.maxLines2 = 1,
    this.onChange,
    this.onChange2,
    this.inputDecoration,
    this.inputDecoration2,
    this.controller,
    this.controller2,
    this.isEdit = true,
    this.isEdit2 = true,
    this.required = false,
    this.required2 = false,
    this.focusNode,
    this.focusNode2,
    this.tagColor = const Color(0xff63728f),
    this.tagColor2 = const Color(0xff63728f),
    this.color = Colors.transparent,
    this.showLine = false,
    this.child,
    this.maxLength = 200,
    this.maxLength2 = 200,
    this.maxNum2,
    this.maxNum,
    this.onlyNumValue,
    this.placesLength,
    this.onlyNumValue2,
    this.placesLength2,
    this.fontSize = 16,
    this.direction = Axis.horizontal,
    this.style = TagCellStyle.style2,
  });
}

enum TagCellStyle { style1, style2 }
