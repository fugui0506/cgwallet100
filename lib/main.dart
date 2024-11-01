import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cgwallet100/common/config/config.dart';
import 'package:flutter/material.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:my_utils/my_utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FilledButton(onPressed: ()  async {
              log('正在获取本机信息...');
              final deviceInfo = await MyDeviceInfo.getDeviceInfo();
              log('${deviceInfo.toJson()}');
            }, child: const Text('获取终端信息')),

            FilledButton(onPressed: ()  async {
              final env = await MyEnvironment.instance.initialize();
              String info = '';
              switch(env) {
                case Environment.test:
                  info = await MyEnvironment.instance.getConfig(MyConfig.urls.testUrls);
                  break;
                case Environment.pre:
                  info = await MyEnvironment.instance.getConfig(MyConfig.urls.preUrls);
                  break;
                case Environment.rel:
                  info = await MyEnvironment.instance.getConfig(MyConfig.urls.relUrls);
                  break;
                case Environment.grey:
                  info = await MyEnvironment.instance.getConfig(MyConfig.urls.greyUrls);
                  break;
                default:
                  info = await MyEnvironment.instance.getConfig(MyConfig.urls.testUrls);
              }

              log('Main页面输出 > 拿到的配置信息是 -> $info');

              final config = info.aesDecrypt(MyConfig.key.aesKey);
              final json = config.toJson();
              wssUrls = List<String>.from(json['ws'].map((e) => e.toString()));

              log('Main页面输出 > 解析后的结果 -> $config');

            }, child: const Text('获取环境配置')),

            FilledButton(onPressed: ()  async {
              try {
                final Duration timeout = Duration(seconds: 10);
                final HttpClient httpClient = HttpClient();

                final HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://wltws.z13a70.com/?X-token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwIiwiSUQiOjE4MSwiVXNlcm5hbWUiOiJmdWd1aTAwNyIsIlBob25lIjoiMTU4MDUwNjAwMDciLCJBdXRob3JpdHlJZCI6MCwiQWNjb3VudFR5cGUiOjEsIklzQXV0aCI6MSwiQnVmZmVyVGltZSI6ODY0MDAsImlzcyI6InFtUGx1cyIsImF1ZCI6WyJHVkEiXSwiZXhwIjoxNzMxMDQzNDExLCJuYmYiOjE3MzA0Mzg2MTF9.DuRlvW7Ube-2-IkwE8wcV7iSjqi1JwUK0cQy0Owfjjg"));
                final HttpClientResponse response = await request.close().timeout(timeout);


                if (response.statusCode >= 200 && response.statusCode < 300) {
                  final String responseBody = await response.transform(utf8.decoder).join();
                  log(responseBody);
                } else {
                  // await Future.delayed(timeout);
                  log('wss连接检测失败 -> ${response.statusCode}');
                }
                httpClient.close();
              } catch (e) {
                log('wss连接检测错误 -> $e');
              }

            }, child: const Text('检测 wss 连接测试')),

            FilledButton(onPressed: ()  async {
              try {
                final Duration timeout = Duration(seconds: 10);

                // 连接到 WebSocket
                final WebSocket socket = await WebSocket.connect("wss://wltws.z13a70.com/?X-token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwIiwiSUQiOjE4MSwiVXNlcm5hbWUiOiJmdWd1aTAwNyIsIlBob25lIjoiMTU4MDUwNjAwMDciLCJBdXRob3JpdHlJZCI6MCwiQWNjb3VudFR5cGUiOjEsIklzQXV0aCI6MSwiQnVmZmVyVGltZSI6ODY0MDAsImlzcyI6InFtUGx1cyIsImF1ZCI6WyJHVkEiXSwiZXhwIjoxNzMxMDQzNDExLCJuYmYiOjE3MzA0Mzg2MTF9.DuRlvW7Ube-2-IkwE8wcV7iSjqi1JwUK0cQy0Owfjjg").timeout(timeout);
                log('已连接到 WebSocket');

                // 监听 WebSocket 的消息
                socket.listen(
                      (data) {
                    log('收到数据: ${data.utf8Decode()}');
                  },
                  onDone: () {
                    log('WebSocket 连接已关闭');
                  },
                  onError: (error) {
                    log('WebSocket 错误: $error');
                  },
                );
              } catch (e) {
                log('WebSocket 连接错误 -> $e');
              }

            }, child: const Text('检测 wss 连接')),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
