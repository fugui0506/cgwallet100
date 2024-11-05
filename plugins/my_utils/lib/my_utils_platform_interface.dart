import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_utils_method_channel.dart';

abstract class MyUtilsPlatform extends PlatformInterface {
  /// Constructs a MyUtilsPlatform.
  MyUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyUtilsPlatform _instance = MethodChannelMyUtils();

  /// The default instance of [MyUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyUtils].
  static MyUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyUtilsPlatform] when
  /// they register themselves.
  static set instance(MyUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
