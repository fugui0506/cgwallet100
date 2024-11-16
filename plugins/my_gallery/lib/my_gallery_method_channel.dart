import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_gallery_platform_interface.dart';

/// An implementation of [MyGalleryPlatform] that uses method channels.
class MethodChannelMyGallery extends MyGalleryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_gallery');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> saveImage({required String path}) async {
    Map<String, dynamic> data = {"path" : path};
    final result = await methodChannel.invokeMethod<bool>('saveImage', data);
    return result;
  }

  @override
  Future<String?> decodeQRCode({required String path}) async {
    Map<String, dynamic> data = {"path" : path};
    final code = await methodChannel.invokeMethod<String>('decodeQRCode', data);
    return code;
  }
}
