import 'package:my_flutter_basic/common/common.dart';
import 'package:my_utils/utils/my_cache.dart';

Future<void> initTheme() async {
  // 初始化主题
  final themeModeCache = await MyCache.getFile('themeMode');
  final themeModeString = await themeModeCache?.readAsString();

  if (themeModeString != null) {
    final themeMode = MyThemeMode.from(themeModeString);
    MyTheme.update(mode: themeMode);
  } else {
    MyTheme.update(mode: MyThemeMode.system);
  }
}