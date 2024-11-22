import 'dart:convert';

import 'package:cgwallet/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_deep_link/my_deep_link.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:my_gallery/my_gallery.dart';
import 'package:my_utils/my_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    MyDio? myDio;
    MyDeepLink.getDeepLink(
      onSuccess: (value) async {
        MyLogger.w('Deep link success: $value');
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Deep Link'),
            content: Text('Deep link success: $value'),
          );
        });
      },
    );
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

                MyLogger.w('设备配置信息 --> ${info.toJson()}');
              },
              child: const Text('获取设备信息'),
            ),
            FilledButton(
                onPressed: ()  async {
                  final env = await MyEnvironment.initialize();

                  String info = '';
                  switch(env) {
                    case Environment.test:
                      info = await MyEnvironment.getConfig(MyConfig.urls.testUrls);
                      break;
                    case Environment.pre:

                      info = await MyEnvironment.getConfig(MyConfig.urls.preUrls);
                      break;
                    case Environment.rel:

                      info = await MyEnvironment.getConfig(MyConfig.urls.relUrls);
                      break;
                    case Environment.grey:
                      info = await MyEnvironment.getConfig(MyConfig.urls.greyUrls);
                      break;
                    default:
                      info = await MyEnvironment.getConfig(MyConfig.urls.testUrls);
                  }
                  info = info.aesDecrypt(MyConfig.key.aesKey);
                  MyLogger.w('解密后的配置信息 --> $info');
                },
                child: const Text('获取环境变量'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = ['test', 'pre', 'prod','rel', 'grey'];
                MyLogger.w('$keywords 转二进制 -> ${MyUint8.encode(keywords)}');
              },
              child: const Text('转二进制'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = [31, 139, 8, 0, 0, 0, 0, 0, 0, 3, 139, 86, 42, 73, 45, 46, 81, 210, 81, 42, 40, 74, 5, 147, 249, 41, 74, 58, 74, 69, 169, 57, 74, 58, 74, 233, 69, 169, 149, 74, 177, 0, 150, 139, 177, 227, 34, 0, 0, 0];
                MyLogger.w('$keywords 二进制转字符串 -> ${MyUint8.decode(keywords)}');
              },
              child: const Text('二进制转字符串'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '这个密码无法加密';
                MyLogger.w(keywords.aesEncrypt(MyConfig.key.aesKey));
              },
              child: const Text('加密'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = 'vHfMg1H8v6wmE2jXyR26wsCDedAQwX4Cnhaivj8px88=';
                MyLogger.w('解密 -> ${keywords.aesDecrypt(MyConfig.key.aesKey)}');
              },
              child: const Text('解密'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '1';
                MyLogger.w('解密 -> ${keywords.fixed(4)}');
              },
              child: const Text('保留小数点'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '收到1发发';
                MyLogger.w('解密 -> ${keywords.isChineseName()}');
              },
              child: const Text('检验是否中文名字'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '收到1发发';
                MyLogger.w('解密 -> ${keywords.hideMiddle(1, 1)}');
              },
              child: const Text('隐藏中间数字'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '{"name":"tom","age":18,"gender":"male","hobbies":["reading","swimming"]}';
                MyLogger.w('格式化输出 -> ${keywords.format()}');
              },
              child: const Text('格式化JSON输出'),
            ),

            FilledButton(
              onPressed: ()  async {
                final keywords = '1212';
                MyLogger.w('$keywords -> ${keywords.toJson()}');
              },
              child: const Text('转 json 格式'),
            ),

            FilledButton(
              onPressed: ()  async {
                await MyCache.putFile('cache_shared_test', '1123123', maxAge: Duration(seconds: 30));
              },
              child: const Text('缓存自定义数据'),
            ),

            FilledButton(onPressed: () async {
              final result = await MyCache.getFile('cache_shared_test');

              if (result == null) {
                MyLogger.w('获取缓存数据 -> null');
                return;
              }

              final data = await result.readAsBytes();
              final string = utf8.decode(data);
              MyLogger.w('获取缓存数据 -> $string');
            }, child: const Text('获取缓存数据')),

            FilledButton(onPressed: () async {
              await MyCache.clear();
            }, child: const Text('清理所有缓存')),

            FilledButton(onPressed: () async {
              await MyCache.getSingleFile('https://watermark.lovepik.com/photo/20211119/large/lovepik-ten-thousand-mountains-tupian-picture_500348227.jpg');
            }, child: const Text('获取网络缓存')),

            FilledButton(
              onPressed: () async {
                showCupertinoDialog(context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Deep Link'),
                      content: Text('Deep link test'),
                    );
                });
              }, child: const Text('弹窗测试')
            ),

            FilledButton(
                onPressed: () async {
                  MyLogger.w("正在获取图片");
                  final imageFile = await MyCache.getSingleFile('https://user-images.githubusercontent.com/13992911/82857992-2c1ed780-9f45-11ea-9e61-56263a4b9992.png');
                  if (imageFile != null) {
                    final result = await MyGallery.decodeQRCode(path: imageFile.path);
                    MyLogger.w("result: $result");
                  } else {
                    MyLogger.w("获取图片失败");
                  }
                }, child: const Text('测试二维码识别')
            ),

            FilledButton(
                onPressed: () async {
                  MyLogger.w("正在下载图片...");
                  final imageFile = await MyCache.getSingleFile('https://user-images.githubusercontent.com/13992911/82857992-2c1ed780-9f45-11ea-9e61-56263a4b9992.png');
                  if (imageFile != null) {
                    final result = await MyGallery.saveImage(path: imageFile.path);
                    MyLogger.w("result: $result");
                  } else {
                    MyLogger.w("保存图片");
                  }
                }, child: const Text('保存图片')
            ),

            FilledButton(
                onPressed: () async {
                  final imageFile = await MyPicker.getImage();
                  if (imageFile!= null) {
                    final result = await MyGallery.decodeQRCode(path: imageFile.path);
                    MyLogger.w("result: $result");
                  }
                }, child: const Text('二维码识别')
            ),

            FilledButton(
                onPressed: () async {
                  final imageFile = await MyPicker.getImage(isCamera: true);
                  if (imageFile!= null) {
                    final result = await MyGallery.decodeQRCode(path: imageFile.path);
                    MyLogger.w("result: $result");
                  }
                }, child: const Text('拍照识别')
            ),


            FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyGallery.scan(onResult: (result) {
                      Navigator.pop(context);
                      MyLogger.w('result: $result');
                      showDialog(context: context, builder: (context) {
                        return Dialog(child: Text("result -> $result"));
                      });
                    })),
                  );
                }, child: const Text('扫码')
            ),

            FilledButton(
                onPressed: () async {
                  myDio = MyDio.initialize(
                    baseOptions: (baseOptions) {
                      return baseOptions.copyWith(
                        baseUrl: 'https://wltadmin.z13a70.com',
                        connectTimeout: Duration(seconds: 30),
                        receiveTimeout: Duration(seconds: 60),
                        contentType: 'application/json; charset=utf-8',
                        // responseType: ResponseType.json,
                      );
                    }
                  );
                }, child: const Text('初始化dio')
            ),

            FilledButton(
                onPressed: () async {
                  myDio?.dio.options.baseUrl = 'https://www.baidu.com';
                }, child: const Text('配置 base_options')
            ),

            FilledButton(
                onPressed: () async {
                  myDio?.dio.options.baseUrl = 'https://www.google.com';
                }, child: const Text('更改 base_options')
            ),

            FilledButton(
                onPressed: () async {
                  myDio?.dio.options.headers = {
                    'x-token': 'your_token',
                  };
                }, child: const Text('配置 x-token')
            ),

            FilledButton(
                onPressed: () async {
                  myDio?.dio.options.headers = {};
                }, child: const Text('删除 x-token')
            ),

            FilledButton(
                onPressed: () async {
                  await myDio?.post(
                    path: '/admin/base/captcha',
                    onSuccess: (response) {
                      print(response);
                    }
                  );
                }, child: const Text('请求')
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
