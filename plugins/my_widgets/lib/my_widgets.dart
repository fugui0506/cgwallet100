
import 'my_widgets_platform_interface.dart';

class MyWidgets {
  Future<String?> getPlatformVersion() {
    return MyWidgetsPlatform.instance.getPlatformVersion();
  }
}
