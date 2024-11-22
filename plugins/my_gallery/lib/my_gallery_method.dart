import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'common/my_permission.dart';
import 'my_gallery_platform_interface.dart';

class MyGallery {
  // Future<String?> getPlatformVersion() {
  //   return MyGalleryPlatform.instance.getPlatformVersion();
  // }

  static Future<bool?> saveImage({required String path}) async {
    bool? result;
    final permission = await MyPermission.storage();
    if (permission) {
      try {
        result = await MyGalleryPlatform.instance.saveImage(path: path);
      } catch (e) {
        log("保存图片出现错误 -> $e");
      }
    }
    return result;
  }

  static Widget scan({
    required void Function(String? result) onResult
  }) {
    bool isCommon = false;
    return MobileScanner(
      onDetect: (barcodeCapture) {
        if (isCommon) return;
        onResult.call(barcodeCapture.barcodes.first.displayValue);
        isCommon = true;
      }
    );
  }

  static Future<String?> decodeQRCode({required String path}) async {
    String? result;
    final MobileScannerController mobileScannerController = MobileScannerController();

    try {
      final BarcodeCapture? barcodeCapture = await mobileScannerController.analyzeImage(path);
      if (barcodeCapture != null && barcodeCapture.barcodes.first.displayValue != null) {
        result = barcodeCapture.barcodes.first.displayValue;
      } else {
        log('插件未扫描到任何结果,使用原生方法继续扫描...');
        result = await MyGalleryPlatform.instance.decodeQRCode(path: path);
      }
    } catch (e) {
      log("二维码识别失败 -> $e");
    }

    await mobileScannerController.stop();
    await mobileScannerController.dispose();
    return result;
  }
}

