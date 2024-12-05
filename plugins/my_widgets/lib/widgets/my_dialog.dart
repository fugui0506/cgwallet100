import 'package:flutter/material.dart';

class MyDialog {
  static final MyDialog _instance = MyDialog._internal();
  factory MyDialog() => _instance;
  MyDialog._internal();

  static Future<dynamic> show(BuildContext context, {
    bool? isDismissible,
    double? radius,
    Widget? child,
    Color? backgroundColor,
  }) => _instance._show(context,
    isDismissible: isDismissible,
    radius: radius,
    child: child,
    backgroundColor: backgroundColor,
  );

  static Future<dynamic> bottomSheet(BuildContext context, {
    Color? backgroundColor,
    double? radius,
    required List<Widget> children,
  }) => _instance._bottomSheet(context,
    children: children,
    backgroundColor: backgroundColor,
    radius: radius
  );

  Future<dynamic> _show(BuildContext context, {
    bool? isDismissible,
    double? radius,
    Widget? child,
    Color? backgroundColor,
  }) async {
    final navigator = Navigator.of(context);

    final isCanPass = await showDialog<dynamic>(context: context, builder: (context) {
      return Dialog(
        backgroundColor: backgroundColor,
        // insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 16.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    });

    if (navigator.mounted && isDismissible == false && isCanPass == null) {
      return _show(navigator.context,
        isDismissible: isDismissible,
        radius: radius,
        child: child,
        backgroundColor: backgroundColor,
      );
    }
    return isCanPass;
  }

  Future<dynamic> _bottomSheet(BuildContext context, {
    Color? backgroundColor,
    double? radius,
    required List<Widget> children,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius ?? 32),
          topRight: Radius.circular(radius ?? 32),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - 20,
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        );
      },
    );
  }
}