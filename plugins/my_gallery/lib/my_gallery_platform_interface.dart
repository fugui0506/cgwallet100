import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_gallery_method_channel.dart';

abstract class MyGalleryPlatform extends PlatformInterface {
  /// Constructs a MyGalleryPlatform.
  MyGalleryPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyGalleryPlatform _instance = MethodChannelMyGallery();

  /// The default instance of [MyGalleryPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyGallery].
  static MyGalleryPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyGalleryPlatform] when
  /// they register themselves.
  static set instance(MyGalleryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> saveImage({required String path}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> decodeQRCode({required String path}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
