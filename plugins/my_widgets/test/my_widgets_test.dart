import 'package:flutter_test/flutter_test.dart';
import 'package:my_widgets/my_widgets_method.dart';
import 'package:my_widgets/my_widgets_platform_interface.dart';
import 'package:my_widgets/my_widgets_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyWidgetsPlatform
    with MockPlatformInterfaceMixin
    implements MyWidgetsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyWidgetsPlatform initialPlatform = MyWidgetsPlatform.instance;

  test('$MethodChannelMyWidgets is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyWidgets>());
  });

  test('getPlatformVersion', () async {
    MyWidgets myWidgetsPlugin = MyWidgets();
    MockMyWidgetsPlatform fakePlatform = MockMyWidgetsPlatform();
    MyWidgetsPlatform.instance = fakePlatform;

    expect(await myWidgetsPlugin.getPlatformVersion(), '42');
  });
}
