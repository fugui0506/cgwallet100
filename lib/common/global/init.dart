import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:my_utils/utils/my_cache.dart';

Future<void> initialized() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemThemeObserver.init(isCanChange: () async {
    final themeModeCache = await MyCache.getFile('themeMode');
    return themeModeCache == null ? true : false;
  });

  SystemLocaleObserver.init(getLangMode: () async {
    final localeCache = await MyCache.getFile('locale');
    final langMode = await localeCache?.readAsString();
    return langMode == null ? null : MyLangMode.fromString(langMode);
  });

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // 初始化主题
    final themeModeCache = await MyCache.getFile('themeMode');
    final themeModeString = await themeModeCache?.readAsString();

    if (themeModeString != null) {
      final themeMode = MyThemeMode.from(themeModeString);
      MyTheme.update(mode: themeMode);
    } else {
      MyTheme.update(mode: MyThemeMode.system);
    }

    // 初始化语言
    final localeCache = await MyCache.getFile('locale');
    final localeString = await localeCache?.readAsString();

    if (localeString != null) {
      final mode = MyLangMode.fromString(localeString);
      MyLang.update(mode: mode);
    } else {
      final mode = MyLangMode.fromLocale(Get.deviceLocale ?? MyLang.defaultMode);
      MyLang.update(mode: mode);
    }

    // 初始化热更新
    startCheckingForHotUpdates(() {
      showMyDialog(
        title: '发现新版本',
        content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
        onConfirm: () => MyDeviceInfo.restartApp(
          notificationTitle: '重新启动APP',
          notificationBody: '点击这里重新启动APP'
        )
      );
    });
  });

  // 导入用户控制器
  // user: 用户控制器
  await Get.put(UserController()).initComplete;
}
