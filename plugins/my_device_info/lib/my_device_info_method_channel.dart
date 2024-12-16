import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';

import 'models/my_device_info_model.dart';
import 'my_device_info_platform_interface.dart';

/// An implementation of [MyDeviceInfoPlatform] that uses method channels.
class MethodChannelMyDeviceInfo extends MyDeviceInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_device_info');

  @override
  Future<MyDeviceInfoModel> getDeviceInfo() async {
    final version = await methodChannel.invokeMethod('getDeviceInfo');
    final jsonStr = jsonEncode(version);
    // debugPrint('通道 => 获取到设备信息 -> $jsonStr');
    final json = jsonDecode(jsonStr);
    final MyDeviceInfoModel myDeviceInfo = MyDeviceInfoModel.fromJson(json);
    return myDeviceInfo;
  }

  @override
  Future<void> restartApp({String? notificationTitle, String? notificationBody}) async {
    if (kIsWeb || Platform.isIOS) {
      await Restart.restartApp(
        notificationTitle: notificationTitle,
        notificationBody: notificationBody,
      );
    } else if (Platform.isAndroid) {
      return methodChannel.invokeMethod('restart');
    }
  }
}
