import 'package:cgwallet/common/common.dart';
import 'package:my_utils/my_utils.dart';

MyWss setMyWss() {
  return MyWss(
    urls: UserController.to.wssUrlList,
    isCanConnect: () async => UserController.to.userToken.isNotEmpty,
    heartbeatMessage: {
      'type': 'ping',
    },
  );
}