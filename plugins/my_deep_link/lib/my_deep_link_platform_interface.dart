import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_deep_link_method_channel.dart';

abstract class MyDeepLinkPlatform extends PlatformInterface {
  /// Constructs a MyDeepLinkPlatform.
  MyDeepLinkPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyDeepLinkPlatform _instance = MethodChannelMyDeepLink();

  /// The default instance of [MyDeepLinkPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyDeepLink].
  static MyDeepLinkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyDeepLinkPlatform] when
  /// they register themselves.
  static set instance(MyDeepLinkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> getDeepLink({void Function(String)? onSuccess}) {
    throw UnimplementedError('getDeepLink() has not been implemented.');
  }
}
