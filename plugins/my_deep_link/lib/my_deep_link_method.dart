// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';

import 'my_deep_link_platform_interface.dart';

class MyDeepLink {
  static Future<void> getDeepLink({
    void Function(String)? onSuccess,
  }) async {
    return MyDeepLinkPlatform.instance.getDeepLink(onSuccess: onSuccess);
  }
}