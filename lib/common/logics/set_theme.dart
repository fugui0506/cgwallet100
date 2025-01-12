import 'package:my_flutter_basic/common/common.dart';
import 'package:my_utils/utils/my_cache.dart';

Future<void> setThemeLight() async {
  await MyTheme.update(mode: MyThemeMode.light);
  await MyCache.putFile('themeMode', MyThemeMode.light.toString());
}

Future<void> setThemeDark() async {
  await MyTheme.update(mode: MyThemeMode.dark);
  await MyCache.putFile('themeMode', MyThemeMode.dark.toString());
}

Future<void> setThemeSystem() async {
  await MyTheme.update(mode: MyThemeMode.system);
  await MyCache.removeFile('themeMode');
}