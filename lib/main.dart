import 'dart:convert';
import 'dart:developer';

import 'package:cgwallet100/common/common.dart';
import 'package:flutter/material.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:my_utils/utils/my_cache.dart';
import 'package:my_utils/utils/my_environment.dart';
import 'package:my_utils/utils/my_string.dart';
import 'package:my_utils/utils/my_uint8.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> wssUrls = [];
  List<String> baseUrls = [];
  final cache = MyCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            FilledButton(
              onPressed: ()  async {
                final info = await MyDeviceInfo.getDeviceInfo();

                log('设备配置信息 --> ${info.toJson()}');
              },
              child: const Text('获取设备信息'),
            ),
            FilledButton(
                onPressed: ()  async {
                  final environment = MyEnvironment.instance;
                  final env = await environment.initialize();

                  String info = '';
                  switch(env) {
                    case Environment.test:
                      info = await environment.getConfig(MyConfig.urls.testUrls);
                      break;
                    case Environment.pre:

                      info = await environment.getConfig(MyConfig.urls.preUrls);
                      break;
                    case Environment.rel:

                      info = await environment.getConfig(MyConfig.urls.relUrls);
                      break;
                    case Environment.grey:
                      info = await environment.getConfig(MyConfig.urls.greyUrls);
                      break;
                    default:
                      info = await environment.getConfig(MyConfig.urls.testUrls);
                  }
                  info = info.aesDecrypt(MyConfig.key.aesKey);
                  log('解密后的配置信息 --> $info');
                },
                child: const Text('获取环境变量'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = ['test', 'pre', 'prod','rel', 'grey'];
                log('$keywords 转二进制 -> ${MyUint8.encode(keywords)}');
              },
              child: const Text('转二进制'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = [31, 139, 8, 0, 0, 0, 0, 0, 0, 3, 139, 86, 42, 73, 45, 46, 81, 210, 81, 42, 40, 74, 5, 147, 249, 41, 74, 58, 74, 69, 169, 57, 74, 58, 74, 233, 69, 169, 149, 74, 177, 0, 150, 139, 177, 227, 34, 0, 0, 0];
                log('$keywords 二进制转字符串 -> ${MyUint8.decode(keywords)}');
              },
              child: const Text('二进制转字符串'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '这个密码无法加密';
                log(keywords.aesEncrypt(MyConfig.key.aesKey));
              },
              child: const Text('加密'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = 'vHfMg1H8v6wmE2jXyR26wsCDedAQwX4Cnhaivj8px88=';
                log('解密 -> ${keywords.aesDecrypt(MyConfig.key.aesKey)}');
              },
              child: const Text('解密'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '1';
                log('解密 -> ${keywords.fixed(4)}');
              },
              child: const Text('保留小数点'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '收到1发发';
                log('解密 -> ${keywords.isChineseName()}');
              },
              child: const Text('检验是否中文名字'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '收到1发发';
                log('解密 -> ${keywords.hideMiddle(1, 1)}');
              },
              child: const Text('隐藏中间数字'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '{"name":"tom","age":18,"gender":"male","hobbies":["reading","swimming"]}';
                log('解密 -> ${keywords.format()}');
              },
              child: const Text('格式化JSON输出'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '1212';
                log('解密 -> ${keywords.toJson()}');
              },
              child: const Text('格式化JSON输出'),
            ),

            FilledButton(
              onPressed: ()  async {
                await cache.putFile('cache_shared_test', '1123123', maxAge: Duration(seconds: 30));
              },
              child: const Text('缓存自定义数据'),
            ),

            FilledButton(onPressed: () async {
              final result = await cache.getFile('cache_shared_test');

              if (result == null) {
                log('获取缓存数据 -> null');
                return;
              }

              final data = await result.readAsBytes();
              final string = utf8.decode(data);
              log('获取缓存数据 -> $string');
            }, child: const Text('获取缓存数据')),

            FilledButton(onPressed: () async {
              await cache.clear();
            }, child: const Text('清理所有缓存')),

            FilledButton(onPressed: () async {
              await cache.getSingleFile('https://watermark.lovepik.com/photo/20211119/large/lovepik-ten-thousand-mountains-tupian-picture_500348227.jpg');
            }, child: const Text('获取网络缓存')),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
