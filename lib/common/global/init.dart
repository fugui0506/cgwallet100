import 'package:cgwallet/common/lang/my_lang.dart';
import 'package:cgwallet/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final themeModeCache = await MyCache.getFile('themeMode');
    final themeModeString = await themeModeCache?.readAsString();

    if (themeModeString != null) {
      final themeMode = MyThemeMode.from(themeModeString);
      MyTheme.update(mode: themeMode);
    } else {
      MyTheme.update(mode: MyThemeMode.system);
    }

    final localeCache = await MyCache.getFile('locale');
    final localeString = await localeCache?.readAsString();

    if (localeString != null) {
      final mode = MyLangMode.fromString(localeString);
      MyLang.update(mode: mode);
    } else {
      final mode = MyLangMode.fromLocale(Get.deviceLocale ?? MyLang.defaultMode);
      MyLang.update(mode: mode);
    }
  });
}
