import 'package:cgwallet/common/common.dart';
import 'package:my_utils/my_utils.dart';

void setMyWss() {
  if (UserController.to.myWss != null) {
    MyLogger.w('MyDio 已经初始化...');
    return;
  }
  UserController.to.myWss = MyWss(
    urls: UserController.to.wssUrlList,
    isCanConnect: () async => true,
    headers: {
      'x-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwIiwiSUQiOjE4MSwiVXNlcm5hbWUiOiJmdWd1aTAwNyIsIlBob25lIjoiMTU4MDUwNjAwMDciLCJBdXRob3JpdHlJZCI6MCwiQWNjb3VudFR5cGUiOjEsIklzQXV0aCI6MSwiQnVmZmVyVGltZSI6ODY0MDAsImlzcyI6InFtUGx1cyIsImF1ZCI6WyJHVkEiXSwiZXhwIjoxNzM2NzUxNzIyLCJuYmYiOjE3MzYxNDY5MjJ9.dk9fbeey1lXW9A55E7AiHOik5fqdROybA1sRhgvDSYk',
    },
    heartbeatMessage: MyUint8.encode({"type": 9}),
    onMessageReceived: (message) {
      // print('Received message: ${MyUint8.decode(message)}');
      // Handle the received message here
    }
  );
}