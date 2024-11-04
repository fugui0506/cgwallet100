// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'models/my_device_info_model.dart';
import 'my_device_info_platform_interface.dart';

/// A web implementation of the MyDeviceInfoPlatform of the MyDeviceInfo plugin.
class MyDeviceInfoWeb extends MyDeviceInfoPlatform {
  /// Constructs a MyDeviceInfoWeb
  MyDeviceInfoWeb();

  static void registerWith(Registrar registrar) {
    MyDeviceInfoPlatform.instance = MyDeviceInfoWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<MyDeviceInfoModel> getDeviceInfo() async {
    final userAgent = web.window.navigator.userAgent;
    final platform = web.window.navigator.platform;
    final brand = web.window.navigator.product;

    String model = "Unknown";
    if (userAgent.contains("Macintosh")) {
      model = "Mac";
    } else if (userAgent.contains("Windows")) {
      model = "Windows PC";
    } else if (userAgent.contains("Linux")) {
      model = "Linux";
    } else if (userAgent.contains("iPhone")) {
      model = "iPhone";
    } else if (userAgent.contains("iPad")) {
      model = "iPad";
    } else if (userAgent.contains("Android")) {
      model = "Android Device";
    }

    return MyDeviceInfoModel(
      model: model,
      id: platform,
      brand: brand,
      systemVersion: userAgent,
      appName: '',
      appVersion: '',
    );
  }

}
