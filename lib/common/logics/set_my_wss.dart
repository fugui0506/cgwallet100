import 'dart:typed_data';

import 'package:my_flutter_basic/common/common.dart';
import 'package:my_utils/my_utils.dart';

void setMyWss() {
  if (UserController.to.myWss != null) {
    MyLogger.w('MyDio 已经初始化...');
    return;
  }
  UserController.to.myWss = MyWss(
    urls: UserController.to.wssUrlList,
    isCanConnect: _isCanConnect,
    headers: _headers(),
    heartbeatMessage: _heartbeatMessage(),
    onMessageReceived: (message) => _onMessageReceived(message),
    onMaxRetryOut: _onMaxRetryOut
  );
}

void _onMaxRetryOut() {
  showMyDialog(
    title: '连接超时',
    content: '请检查您的网络连接并重试',
    confirmText: '重试',
    onConfirm: () {
      UserController.to.myWss?.reset();
    }
  );
}

void _onMessageReceived(dynamic message) {
  // Handle the received message here
  // You can use the `message` parameter to parse the JSON data and perform your desired actions
}

Future<bool> _isCanConnect() async {
  return true;
}

Map<String, dynamic> _headers() {
  return {
    'x-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwIiwiSUQiOjE4MSwiVXNlcm5hbWUiOiJmdWd1aTAwNyIsIlBob25lIjoiMTU4MDUwNjAwMDciLCJBdXRob3JpdHlJZCI6MCwiQWNjb3VudFR5cGUiOjEsIklzQXV0aCI6MSwiQnVmZmVyVGltZSI6ODY0MDAsImlzcyI6InFtUGx1cyIsImF1ZCI6WyJHVkEiXSwiZXhwIjoxNzM2NzUxNzIyLCJuYmYiOjE3MzYxNDY5MjJ9.dk9fbeey1lXW9A55E7AiHOik5fqdROybA1sRhgvDSYk',
  };
}

Uint8List _heartbeatMessage() {
  return MyUint8.encode({"type": 9});
}