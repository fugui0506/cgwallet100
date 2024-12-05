import 'package:flutter/material.dart';
import 'package:my_widgets/my_widgets.dart';

void showLoading() => MyAlert.showLoading();
void hideLoading() => MyAlert.hideLoading();
void showBlock() => MyAlert.showBlock();
void hideBlock() => MyAlert.hideBlock();
void showSnack({Widget? child}) => MyAlert.showSnack(child: child);

Future<dynamic> showAlert(BuildContext context, {
  String title = '',
  TextStyle titleStyle = const TextStyle(fontSize: 18),
  String content = '',
  TextStyle contentStyle = const TextStyle(fontSize: 13),
  bool isDismissible = true,
  bool isModal = true,
  Color backgroundColor = Colors.white,
}) async {
  final titleBox = Text(title, style: titleStyle);
  final contentBox = Text(content, style: contentStyle);

  final cancelButton = FilledButton(
    child: Text('Cancel'),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  final confirmButton = FilledButton(
    child: Text('OK'),
    onPressed: () async {
      Navigator.pop(context, 'Dialog Result');
    },
  );

  final column = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title.isNotEmpty) titleBox,
      if (title.isNotEmpty) SizedBox(height: 10),
      if (content.isNotEmpty) contentBox,
      if (content.isNotEmpty) SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          cancelButton,
          SizedBox(width: 10),
          confirmButton,
        ],
      ),
    ],
  );

  final child = Container(
    padding: const EdgeInsets.all(16),
    child: column,
  );

  return MyDialog.show(context,
    isDismissible: isDismissible,
    radius: 20,
    backgroundColor: backgroundColor,
    child: child,
  );
}