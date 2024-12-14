import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_widgets/my_widgets.dart';

void showMyLoading() => MyAlert.showLoading();
void hideMyLoading() => MyAlert.hideLoading();
void showMyBlock() => MyAlert.showBlock();
void hideMyBlock() => MyAlert.hideBlock();
void showMySnack({Widget? child}) => MyAlert.showSnack(child: child);

Future<dynamic> showMyDialog({
  String title = '',
  String content = '',
  bool isDismissible = true,
  Color? backgroundColor,
  String confirmText = '',
  String cancelText = '',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) async {
  final titleStyle = const TextStyle(fontSize: 16);
  final contentStyle = const TextStyle(fontSize: 13);

  final titleBox = Text(title, style: titleStyle);
  final contentBox = Text(content, style: contentStyle);

  final cancelButton = ElevatedButton(
    child: Text(cancelText),
    onPressed: () {
      Get.back();
      onCancel?.call();
    },
  );

  final confirmButton = ElevatedButton(
    child: Text('OK'),
    onPressed: () async {
      Get.back(result: 'Dialog Result');
      onConfirm?.call();
    },
  );

  final column = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title.isNotEmpty)
        titleBox,
      if (content.isNotEmpty)
        SizedBox(height: 10),
      if (content.isNotEmpty)
        contentBox,
      if (onConfirm!= null || onCancel!= null)
        SizedBox(height: 20),
      if (onConfirm!= null || onCancel!= null)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (onCancel != null) cancelButton,
            if (onCancel != null && onConfirm != null) SizedBox(width: 10),
            if (onConfirm != null) confirmButton,
          ],
        ),
    ],
  );

  final child = Container(
    padding: const EdgeInsets.all(16),
    child: column,
  );

  if (Get.context != null) {
    return MyDialog.show(Get.context!,
      isDismissible: isDismissible,
      radius: 20,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}