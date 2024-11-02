
import '../models/my_device_info_model.dart';
import 'my_device_info_platform_interface.dart';

class MyDeviceInfo {
  static Future<MyDeviceInfoModel> getDeviceInfo() async {
    try {
      final result = await MyDeviceInfoPlatform.instance.getDeviceInfo();
      return result;
    } catch(e) {
      return MyDeviceInfoModel.empty();
    }
  }
}
