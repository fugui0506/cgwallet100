import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_utils/utils/my_logger.dart';

part 'my_colors.dart';
part 'my_styles.dart';
part 'extension.dart';
part 'my_icons.dart';

class MyTheme {
  /// - 改变主题
  static Future<void> changeThemeMode(String mode) async {
    switch (mode) {
      case '1':
        Get.changeThemeMode(ThemeMode.dark);
        setAndroidDeviceBar(Brightness.light);
        MyLogger.w('当前主题：暗色');
        break;
      case '2':
        Get.changeThemeMode(ThemeMode.light);
        setAndroidDeviceBar(Brightness.dark);
        MyLogger.w('当前主题：亮色');
        break;
      default:
        Get.changeThemeMode(ThemeMode.system);
        setAndroidDeviceBar(Get.isPlatformDarkMode ? Brightness.light : Brightness.dark);
        MyLogger.w('当前主题：跟随系统');
        break;
    }
    // MyShared.to.set(MyConfig.shard.themeModeKey, mode);
    // DeviceService.to.themeMode.value = mode;
  }

  /// - 将顶部状态栏和底部状态栏设置成透明
  static Future<void> setAndroidDeviceBar(Brightness brightness) async {
    if (!GetPlatform.isAndroid) return;
    // 显示顶部栏(隐藏底部栏，没有这个的话底部状态栏的透明度无法实现)
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // 状态栏和导航栏的颜色样式
    final style = SystemUiOverlayStyle(
      // 状态栏的背景颜色，这里设为透明
      statusBarColor: Colors.transparent,
      // 状态栏图标的亮度，这里设为亮色
      statusBarIconBrightness: brightness,
      // 状态栏的亮度，这里设为暗色
      statusBarBrightness: brightness,
      // 控制系统状态栏的对比度是否被强制增强
      // systemStatusBarContrastEnforced: true,

      // 设置系统导航栏的背景颜色
      systemNavigationBarColor: Colors.transparent,
      // 设置系统导航栏与应用内容之间分割线的颜色
      systemNavigationBarDividerColor: Colors.transparent,
      // 设置系统导航栏图标的亮度
      systemNavigationBarIconBrightness: brightness,
      // 强制增强导航栏图标和文本的对比度
      // systemNavigationBarContrastEnforced: true,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// - 强制竖屏：用到了SystemChrome服务，所以需要初始化
  static Future<void> setPreferredOrientations() async {
    // 强制竖屏：用到了SystemChrome服务，所以需要初始化
    // 如：WidgetsFlutterBinding.ensureInitialized();
    var option = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
    await SystemChrome.setPreferredOrientations(option);
  }

  /// - 去掉安卓手机的底部导航栏
  static Future<void> removeNavigationBar() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }

  /// - 亮色主题
  static ThemeData get light => ThemeData(
    platform: TargetPlatform.iOS, 
    useMaterial3: true, brightness: 
    Brightness.light
  );

  /// - 暗色主题
  static ThemeData get dark => ThemeData(
    platform: TargetPlatform.iOS, 
    useMaterial3: true, 
    brightness: Brightness.dark
  );
}
