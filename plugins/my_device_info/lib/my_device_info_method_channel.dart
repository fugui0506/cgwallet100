import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:my_device_info/my_device_info.dart';

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
    final json = jsonDecode(jsonStr);
    final MyDeviceInfoModel myDeviceInfo = MyDeviceInfoModel.fromJson(json);
    return myDeviceInfo;
  }
}
