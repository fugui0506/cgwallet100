import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_utils/utils/my_logger.dart';

part 'my_colors.dart';
part 'my_styles.dart';
part 'my_icons.dart';

class MyTheme {
  static final MyTheme _instance = MyTheme._internal();
  factory MyTheme() => _instance;
  MyTheme._internal();

  static Future<void> update({required MyThemeMode mode, void Function(MyThemeMode mode)? onSuccess}) => _instance._update(mode: mode, onSuccess: onSuccess);
  static Future<void> setSystemUIOverlayStyle(Brightness brightness) => _instance._setSystemUIOverlayStyle(brightness);
  static void setPreferredOrientations() => _instance._setPreferredOrientations();
  static void removeNavigationBar() => _instance._removeNavigationBar();

  /// - 改变主题
  Future<void> _update({
    required MyThemeMode mode,
    void Function(MyThemeMode mode)? onSuccess,
  }) async {
    switch (mode) {
      case MyThemeMode.dark:
        Get.changeThemeMode(ThemeMode.dark);
        _instance._setSystemUIOverlayStyle(Brightness.dark);
        MyLogger.w('已更改主题 -> 🌛Dark');
        break;
      case MyThemeMode.light:
        Get.changeThemeMode(ThemeMode.light);
        _instance._setSystemUIOverlayStyle(Brightness.light);
        MyLogger.w('已更改主题 -> ☀️Light');
        break;
      default:
        Get.changeThemeMode(ThemeMode.system);
        _instance._setSystemUIOverlayStyle(Get.isPlatformDarkMode ? Brightness.dark : Brightness.light);
        MyLogger.w('已更改主题 ->️ 🌗 System');
        break;
    }
    onSuccess?.call(mode);
    MyLogger.w("系统主题模式 -> ${Get.isPlatformDarkMode ?"🌛Dark" : "☀️Light"}");
  }

  Future<void> _setSystemUIOverlayStyle(Brightness brightness) async {
    // if (!GetPlatform.isAndroid) return;

    // 设置系统导航栏样式
    final style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      systemNavigationBarColor: brightness == Brightness.light ? Colors.white : Colors.black,
      systemNavigationBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: brightness == Brightness.light ? Colors.white : Colors.black, // 不设置分割线颜色
    );

    // 设置系统导航栏模式
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // 应用样式
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// - 强制竖屏
  Future<void> _setPreferredOrientations() async {
    var option = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
    await SystemChrome.setPreferredOrientations(option);
  }

  /// - 去掉安卓手机的底部导航栏
  Future<void> _removeNavigationBar() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }

  /// - 亮色主题
  ThemeData get light => ThemeData(
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  /// - 暗色主题
  ThemeData get dark => ThemeData(
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}

class SystemThemeObserver with WidgetsBindingObserver {
  static SystemThemeObserver? _instance;

  factory SystemThemeObserver({
    required Future<bool> Function() isCanChange,
  }) {
    _instance ??= SystemThemeObserver._internal(isCanChange: isCanChange);
    return _instance!;
  }

  SystemThemeObserver._internal({
    required this.isCanChange,
  });

  final Future<bool> Function() isCanChange;

  static void init({
    required Future<bool> Function() isCanChange,
  }) {
    SystemThemeObserver(isCanChange: isCanChange)._init();
  }

  void _init() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() async {
    if (await isCanChange()) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      Get.changeThemeMode(
        brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      );
      MyTheme.setSystemUIOverlayStyle(brightness);
      log("系统主题发生了改变 -> $brightness");
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}

enum MyThemeMode {
  system('system'),
  light('light'),
  dark('dark');

  final String mode;

  const MyThemeMode(this.mode);

  static MyThemeMode from(String mode) {
    switch (mode) {
      case 'light':
        return MyThemeMode.light;
      case 'dark':
        return MyThemeMode.dark;
      default:
        return MyThemeMode.system;
    }
  }

  @override
  String toString() {
    return mode;
  }
}
