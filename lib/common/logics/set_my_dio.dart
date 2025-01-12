import 'package:my_flutter_basic/common/common.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:my_utils/my_utils.dart';

Future<void> setMyDio({
  required String baseUrl,
}) async {
  final info = await MyDeviceInfo.getDeviceInfo();
  String device = '${info.brand}, ${info.id}, ${info.model}, ${info.systemVersion}';
  UserController.to.myDio = MyDio(
    baseOptions: (option) => option.copyWith(
      baseUrl: baseUrl,
      connectTimeout: MyConfig.time.outDefault,
      receiveTimeout: MyConfig.time.outDefault,
      sendTimeout: MyConfig.time.outDefault,
    ),
    headers: {
      'x-token': UserController.to.userToken,
      'x-device': device,
      'x-timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    },
    onResponse: (response) async {
      if (response.data is Map<String, dynamic>) {
        final responseModel = ResponseModel.fromJson(response.data);
        if ([4].contains(responseModel.code)) {

        } else if ([2].contains(responseModel.code)) {

        }
      }
    },
    dioCode: 0,
  );
}