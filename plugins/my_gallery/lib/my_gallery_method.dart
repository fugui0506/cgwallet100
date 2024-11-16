import 'dart:developer';
import 'common/my_permission.dart';
import 'my_gallery_platform_interface.dart';

class MyGallery {
  // Future<String?> getPlatformVersion() {
  //   return MyGalleryPlatform.instance.getPlatformVersion();
  // }

  static Future<bool?> saveImage({required String path}) async {
    bool? result;
    final permission = await MyPermission.instance.storage();
    if (permission) {
      try {
        result = await MyGalleryPlatform.instance.saveImage(path: path);
      } catch (e) {
        log("保存图片出现错误 -> $e");
      }
    }
    return result;
  }

  static Future<String?> decodeQRCode({required String path}) async {
    String? result;
    try {
      result = await MyGalleryPlatform.instance.decodeQRCode(path: path);
    } catch (e) {
      log("二维码识别失败 -> $e");
    }
    return result;
  }
}

