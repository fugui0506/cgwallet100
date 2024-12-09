import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_utils/my_utils.dart';
import 'package:my_widgets/my_widgets.dart';

import 'common/common.dart';

void main() async {
  await initialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: '/',
      title: '王富贵钱包',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      themeMode: ThemeMode.light,
      locale: Get.deviceLocale,
      fallbackLocale: MyLang.fallbackMode,
      localizationsDelegates: MyLang.localizationsDelegates,
      supportedLocales: MyLang.supportedLocales,
      debugShowCheckedModeBanner: false,
      translations: MyLang(),
      defaultTransition: Transition.rightToLeftWithFade,
      // getPages: MyPages.getPages,
      popGesture: true,
      transitionDuration: const Duration(milliseconds: 500),
      builder: (context, child) => MyAlert(key: MyAlert.globalKey, child: child),
    );
  }
}

class HomeScreen extends StatelessWidget {

  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final wrap = Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 10,
      children: [
        ElevatedButton(
          onPressed: () async {
            await MyTheme.update(mode: MyThemeMode.light);
            await MyCache.putFile('themeMode', MyThemeMode.light.toString());
          },
          child: Text('亮色主题'),
        ),
        ElevatedButton(
          onPressed: () async {
            await MyTheme.update(mode: MyThemeMode.dark);
            await MyCache.putFile('themeMode', MyThemeMode.dark.toString());
          },
          child: Text('暗色主题'),
        ),
        ElevatedButton(
          onPressed: () async {
            await MyTheme.update(mode: MyThemeMode.system);
            await MyCache.removeFile('themeMode');
          },
          child: Text('跟随系统'),
        ),
        Text(Lang.activityClosed.tr),
        ElevatedButton(
          onPressed: () async {
            final myLocale = MyLangMode.fromString('zh');
            await MyLang.update(mode: myLocale);
            await MyCache.putFile('locale', myLocale.toString());
          },
          child: Text('中文'),
        ),
        ElevatedButton(
          onPressed: () async {
            final myLocale = MyLangMode.fromString('en');
            await MyLang.update(mode: myLocale);
            await MyCache.putFile('locale', myLocale.toString());
          },
          child: Text('英文'),
        ),
        ElevatedButton(
          onPressed: () async {
            await MyCache.removeFile('locale');
          },
          child: Text('自动适配'),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Testing')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: wrap
      ),
    );
  }
}