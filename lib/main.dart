import 'package:cgwallet/common/logics/set_my_wss.dart';
import 'package:cgwallet/common/models/captcha_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:my_gallery/my_gallery.dart';
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
          child: Text('自动适配语言'),
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
            showMyDialog(
              title: '重新启动',
              content: '是否现在重新启动并更新？',
              confirmText: '确认',
              cancelText: '取消',
              onConfirm: () {
                MyDeviceInfo.restartApp(
                  notificationTitle: '测试用的',
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
              case Environment.rel:
                showMySnack(child: Text('当前环境：正式', style: TextStyle(color: Colors.white, fontSize: 13)));
                showMyLoading();
                await getOptions(urls: MyConfig.urls.relUrls);
                hideMyLoading();
                break;
              case Environment.pre:
                showMyLoading();
                await getOptions(urls: MyConfig.urls.preUrls);
                hideMyLoading();
                break;
              case Environment.grey:
                showMyLoading();
                await getOptions(urls: MyConfig.urls.greyUrls);
                hideMyLoading();
                break;
              default:
                showMyLoading();
                await getOptions(urls: MyConfig.urls.testUrls);
                hideMyLoading();
                break;
            }

            showMyDialog(
              title: '返回数据',
              content: 'wssUrls：${UserController.to.baseUrlList},baseUrls：${UserController.to.wssUrlList}',
              onConfirm: () {},
              onCancel: () {},
            );
          },
          child: Text('获取配置'),
        ),

        ElevatedButton(
          onPressed: () async {
            showMyLoading();
            await getBaseUrl(
              urls: UserController.to.baseUrlList,
              onSuccess: (baseUrl) async {
                await setMyDio(baseUrl: baseUrl);
                showMyDialog(
                  title: '配置成功',
                  content: 'baseUrl：$baseUrl',
                  onConfirm: () {},
                  onCancel: () {},
                );
              },
              onError: () {
                // print('获取baseUrl失败');
              }
            );
            hideMyLoading();
          },
          child: Text('配置dio'),
        ),

        ElevatedButton(
          onPressed: () async {
            CaptchaModel data = CaptchaModel.empty();
            showMyLoading();
            await data.update();
            hideMyLoading();
            MyLogger.w('${data.toJson()}');
            showMyDialog(
              title: '返回数据',
              content: '${data.toJson()}',
              onConfirm: () {},
              onCancel: () {},
            );
          },
          child: Text('测试接口'),
        ),

        ElevatedButton(
          onPressed: () {
            setMyWss();
            UserController.to.myWss?.connect();
          },
          child: Text('连接wss'),
        ),

        ElevatedButton(
          onPressed: () {
            showMyDialog(
              title: '断开通信',
              content: '是否确认断开与服务器的连接？',
              confirmText: '确认',
              cancelText: '取消',
              onConfirm: () => UserController.to.myWss?.close()
            );
          },
          child: Text('断开wss'),
        ),

        ElevatedButton(
          onPressed: () async {
            Get.to(()=> Scaffold(
              appBar: AppBar(title: Text('扫一扫'), centerTitle: true),
              body: MyGallery.scan(onResult: (result) {
                MyAudio.play(MyAudioPath.scan);
                Get.back();
                print('result: $result');
              }),
            ));
          },
          child: Text('扫一扫'),
        ),

        ElevatedButton(
          onPressed: () async {
            final image = await MyPicker.getImage();
            if (image!= null) {
              final result = await MyGallery.decodeQRCode(path: image.path);
              showMySnack(child: Text(result ?? '没有扫到任何信息'));
            }
          },
          child: Text('识别二维码'),
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