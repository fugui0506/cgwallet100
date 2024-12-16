import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'models/my_device_info_model.dart';
import 'my_device_info_method_channel.dart';

abstract class MyDeviceInfoPlatform extends PlatformInterface {
  /// Constructs a MyDeviceInfoPlatform.
  MyDeviceInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyDeviceInfoPlatform _instance = MethodChannelMyDeviceInfo();

  /// The default instance of [MyDeviceInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyDeviceInfo].
  static MyDeviceInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyDeviceInfoPlatform] when
  /// they register themselves.
  static set instance(MyDeviceInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<MyDeviceInfoModel> getDeviceInfo() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> restartApp({String? notificationTitle, String? notificationBody}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
