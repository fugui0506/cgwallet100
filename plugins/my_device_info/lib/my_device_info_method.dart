import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'models/my_device_info_model.dart';
import 'my_device_info_platform_interface.dart';

class MyDeviceInfo {
  static Future<MyDeviceInfoModel> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    if (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      try {
        final result = await MyDeviceInfoPlatform.instance.getDeviceInfo();
        result.appName = packageInfo.appName;
        result.appVersion = packageInfo.version;
        return result;
      } catch(e) {
        return MyDeviceInfoModel.empty();
      }
    } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      return MyDeviceInfoModel(
        model: windowsInfo.productName,
        id: windowsInfo.deviceId,
        brand: "Windows",
        systemVersion: windowsInfo.displayVersion,
        appName: packageInfo.appName,
        appVersion: packageInfo.version,
      );
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfo.linuxInfo;
      return MyDeviceInfoModel(
        model: linuxInfo.prettyName,
        id: linuxInfo.id,
        brand: "Linux",
        systemVersion: "${linuxInfo.version}",
        appName: packageInfo.appName,
        appVersion: packageInfo.version,
      );
    }
    return MyDeviceInfoModel.empty();
  }

  static Future<void> restartApp({String? notificationTitle, String? notificationBody}) async {
    return MyDeviceInfoPlatform.instance.restartApp(notificationTitle: notificationTitle, notificationBody: notificationBody);
  }
}
