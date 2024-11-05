// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// import 'package:web/web.dart' as web;

import 'my_utils_platform_interface.dart';

/// A web implementation of the MyUtilsPlatform of the MyUtils plugin.
class MyUtilsWeb extends MyUtilsPlatform {
  /// Constructs a MyUtilsWeb
  MyUtilsWeb();

  static void registerWith(Registrar registrar) {
    MyUtilsPlatform.instance = MyUtilsWeb();
  }
}
