import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_device_info/my_device_info.dart';
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
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 0,
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
            final info = await MyDeviceInfo.getDeviceInfo();
            showMyDialog(
              title: info.appName,
              content: 'version: ${info.appVersion}, 其他信息：${info.brand}, ${info.id}, ${info.model}, ${info.systemVersion}',
              confirmText: '关闭',
            );
          },
          child: Text('版本检查'),
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
            showMyDialog(
              title: '重新启动',
              content: '是否现在重新启动并更新？',
              confirmText: '确认',
              cancelText: '取消',
              onConfirm: () {
                Restart.restartApp(
                  notificationTitle: '重新启动',
                  notificationBody: '点击这里重新启动APP',
                );
              },
              onCancel: () {
                Get.back();
              },
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
            showMyDialog(
              title: '测试啊的',
              content: '测试弹窗的小题内容阿道夫阿拉斯加的弗拉索夫阿斯顿客服了解拉萨地方啦快结束的福利啊结束的福利就啊谁来对抗肌肤啊三闾大夫？',
            );
          },
          child: Text('弹窗测试全无'),
        ),

        ElevatedButton(
          onPressed: () async {
            showMyDialog(
              title: '测试啊的',
              content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
              onConfirm: () {}
            );
          },
          child: Text('弹窗测试有确认'),
        ),

        ElevatedButton(
          onPressed: () async {
            showMyDialog(
              title: '测试啊的',
              content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
              onCancel: () {}
            );
          },
          child: Text('弹窗测试有取消'),
        ),

        ElevatedButton(
          onPressed: () async {
            showMyDialog(
              title: '弹窗测试',
              content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
              onCancel: () {},
              onConfirm: () {}
            );
          },
          child: Text('弹窗测试都有'),
        ),

        ElevatedButton(
          onPressed: () async {
            showMyDialog(
                // title: '弹窗测试',
                content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
                onCancel: () {},
                onConfirm: () {}
            );
          },
          child: Text('无标题的弹窗'),
        ),

        ElevatedButton(
          onPressed: () async {
            showMyDialog(
              title: '弹窗测试',
              //   content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
                onCancel: () {},
                onConfirm: () {}
            );
          },
          child: Text('无内容的弹窗'),
        ),

        ElevatedButton(
          onPressed: () async {
            showMyDialog(
                // title: '弹窗测试',
                //   content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
                onCancel: () {},
                onConfirm: () {}
            );
          },
          child: Text('无标题和内容'),
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