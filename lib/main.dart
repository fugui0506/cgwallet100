import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_utils/my_utils.dart';
import 'package:my_widgets/my_widgets.dart';
import 'package:restart_app/restart_app.dart';

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
        ElevatedButton(
          onPressed: () async {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
          child: Text('退出APP'),
        ),
        ElevatedButton(
          onPressed: () async {
            Restart.restartApp(
              notificationTitle: '重新启动',
              notificationBody: '点击这里重新启动APP',
            );
          },
          child: Text('重新启动APP'),
        ),
        ElevatedButton(
          onPressed: () async {
            final environment = await MyEnvironment.initialize();
            switch (environment){
              case Environment.test:
                showMySnack(child: Text('当前环境：开发', style: TextStyle(color: Colors.white, fontSize: 13)));
                break;
              case Environment.pre:
                showMySnack(child: Text('当前环境：预发', style: TextStyle(color: Colors.white, fontSize: 13)));
                break;
              case Environment.grey:
                showMySnack(child: Text('当前环境：灰度', style: TextStyle(color: Colors.white, fontSize: 13)));
                break;
              default:
                showMySnack(child: Text('当前环境：正式', style: TextStyle(color: Colors.white, fontSize: 13)));
            }
          },
          child: Text('获取环境参数'),
        ),

        ElevatedButton(
          onPressed: () async {
          },
          child: Text('配置DIO'),
        ),

        ElevatedButton(
          onPressed: () async {
            showMyDialog(
                title: '测试啊的',
                content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
            );
          },
          child: Text('弹窗测试'),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text(Lang.activityClosed.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: wrap
      ),
    );
  }
}