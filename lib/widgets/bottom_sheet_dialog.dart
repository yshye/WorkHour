import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetDialog extends StatelessWidget {
  final Widget title;
  final Widget? titleLeft;
  final Widget? titleRight;
  final Color backgroundColor;
  final List<Widget> children;
  final Widget? operation;
  final VoidCallback? onOk;
  final double height;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry padding;

  const BottomSheetDialog({
    Key? key,
    required this.title,
    this.children = const [],
    this.padding = const EdgeInsets.only(left: 5, right: 5, bottom: 10),
    this.operation,
    this.titleLeft,
    this.titleRight,
    this.height = 300,
    this.onOk,
    this.onClose,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: height,
      duration: const Duration(milliseconds: 100),
      child: Padding(
        padding: padding,
        child: Material(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            height: height,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(
                        left: 8.0,
                        child: titleLeft ??
                            CupertinoButton(
                              child: const Text('取消',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 18)),
                              padding: const EdgeInsets.all(5),
                              onPressed: onClose ?? Get.back,
                            ),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 40,
                        child: title,
                      ),
                      Positioned(
                        right: 8.0,
                        child: titleRight ??
                            CupertinoButton(
                              child: const Text('确认',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18)),
                              padding: const EdgeInsets.all(5),
                              onPressed: onOk,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: children),
                    ),
                  ),
                  Container(child: operation ?? Container(height: 15))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
