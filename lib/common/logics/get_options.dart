import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:my_flutter_basic/common/common.dart';
import 'package:my_utils/utils/my_logger.dart';
import 'package:my_utils/utils/my_string.dart';

Future<void> getOptions({
  required List<String> urls,
  void Function()? onSuccess,
  void Function()? onError,
}) async {
  if (UserController.to.wssUrlList.isNotEmpty && UserController.to.baseUrlList.isNotEmpty) {
    MyLogger.w('配置已获取请勿重复操作...');
    onSuccess?.call();
    return;
  }

  final client = HttpClient();
  final completer = Completer<String>();
  final tasks = <Future>[];

  for (var url in urls) {
    tasks.add(Future(() async {
      try {
        final uri = Uri.parse(url);
        final request = await client.getUrl(uri).timeout(MyConfig.time.outCheck);
        final response = await request.close();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          final responseData = await response.transform(utf8.decoder).join();
          if (!completer.isCompleted) {
            completer.complete(responseData); // 返回第一个成功的结果
          }
        } else {
          MyLogger.w('获取配置发生了错误 --> HTTP 状态码: ${response.statusCode}');
        }
      } catch (e) {
        MyLogger.w('获取配置发生了错误 --> $e');
      }
    }));
  }

  String data = '';

  try {
    data = await completer.future.timeout(MyConfig.time.outCheck);
  } catch (e) {
    MyLogger.w('获取配置超时或发生其他错误 --> $e');
  }

  client.close();

  if (data.isNotEmpty) {
    data = data.aesDecrypt(MyConfig.key.aesKey);
    final json = jsonDecode(data);

    MyLogger.l();

    final List<dynamic> baseUrls = json['api'];
    UserController.to.baseUrlList.clear();
    for (var element in baseUrls) {
      UserController.to.baseUrlList.add(element.toString());
    }

    MyLogger.w('获取到 API 地址 --> ${UserController.to.baseUrlList}');

    final List<dynamic> wss = json['ws'];
    UserController.to.wssUrlList.clear();
    for (var element in wss) {
      UserController.to.wssUrlList.add(element.toString());
    }

    MyLogger.w('获取到 WSS 地址 --> ${UserController.to.wssUrlList}');
    MyLogger.l();

    onSuccess?.call();
    return;
  } else {
    onError?.call();
    return;
  }
}