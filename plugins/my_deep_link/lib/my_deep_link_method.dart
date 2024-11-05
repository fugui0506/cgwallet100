import 'my_deep_link_platform_interface.dart';

class MyDeepLink {
  Future<String?> getPlatformVersion() {
    return MyDeepLinkPlatform.instance.getPlatformVersion();
  }
}