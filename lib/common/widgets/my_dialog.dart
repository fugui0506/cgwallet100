import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_widgets/my_widgets.dart';

void showMyLoading() => MyAlert.showLoading();
void hideMyLoading() => MyAlert.hideLoading();
void showMyBlock() => MyAlert.showBlock();
void hideMyBlock() => MyAlert.hideBlock();
void showMySnack({Widget? child}) => MyAlert.showSnack(child: child);

Future<void> showMyDialog({
  String? title,
  String? content,
  bool isDismissible = true,
  Color? backgroundColor,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  double? margin,
  double? borderRadius,
}) async {
  final titleStyle = const TextStyle(fontSize: 16);
  final contentStyle = const TextStyle(fontSize: 13);

  final cancelButton = ElevatedButton(
    child: Text(cancelText ?? '取消'),
    onPressed: () {
      Get.backLegacy();
      onCancel?.call();
    },
  );

  final confirmButton = ElevatedButton(
    child: Text(confirmText ?? '确认'),
    onPressed: () async {
      Get.backLegacy(result: 'Dialog Result');
      onConfirm?.call();
    },
  );

  final column = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null) Text(title, style: titleStyle),
      if (content != null && title != null) SizedBox(height: 16),
      if (content != null)  Flexible(child: SingleChildScrollView(scrollDirection: Axis. vertical, child: Text(content, style: contentStyle))),
      if ((title != null || content != null) && (confirmText != null || cancelText != null || onConfirm != null || onCancel != null)) SizedBox(height: 16),
      if (confirmText != null || cancelText != null || onConfirm != null || onCancel != null)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (cancelText != null || onCancel != null) cancelButton,
            if ((cancelText != null || onCancel != null) && (confirmText != null || onConfirm != null)) SizedBox(width: 10),
            if (confirmText != null || onConfirm != null) confirmButton,
          ],
        ),
    ],
  );

  final child = Container(
    padding: EdgeInsets.fromLTRB(24, 24, 24, cancelText != null || onCancel != null || confirmText != null || onConfirm != null ? 16 : 28),
    child: column,
  );

  final result = await Get.generalDialog<dynamic>(
    barrierDismissible: isDismissible,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: Dialog(
          clipBehavior: Clip.antiAlias,
          insetPadding: margin == null ? const EdgeInsets.all(32) : EdgeInsets.all(margin),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius == null ? BorderRadius.circular(10) : BorderRadius.circular(borderRadius)),
          child: child,
        ),
      );
    },
  );

  if (isDismissible == false && result == null) {
    showMyDialog(
      title: title,
      content: content,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      margin: margin,
      borderRadius: borderRadius,
    );
  }
}
