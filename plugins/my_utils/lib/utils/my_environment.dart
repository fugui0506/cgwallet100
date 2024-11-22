import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';


class MyEnvironment {
  static final MyEnvironment _instance = MyEnvironment._internal();
  factory MyEnvironment() => _instance;
  MyEnvironment._internal();

  static Future<Environment> initialize() => _instance._initialize();
  static Future<String> getConfig(List<String> urls) => _instance._getConfig(urls);

  Future<Environment> _initialize() async {
    const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'test');

    switch (environment) {
      case 'test':
        return Environment.test;
      case 'pre':
        return Environment.pre;
      case 'rel':
        return Environment.rel;
      case 'grey':
        return Environment.grey;
      default:
        return Environment.test;
    }
  }

  Future<String> _getConfig(List<String> urls) async {
    final Duration timeout = Duration(seconds: 10);
    final Dio dio = Dio();
    String result = '';

    await Future.any(urls.asMap().entries.map((e) async {
      log('正在获取第 ${e.key + 1} 个地址的配置 -> ${e.value}');
      try {
        final request = await dio.get(e.value,
          options: Options(responseType: ResponseType.plain),
        ).timeout(timeout);
        if (request.statusCode != null && (request.statusCode! >= 200 && request.statusCode! < 300)) {
          final String responseBody = request.data.toString();
          if (result.isEmpty) {
            result = responseBody;
            log('第 ${e.key + 1} 个地址获取配置成功 -> $responseBody');
          } else {
            // await Future.delayed(timeout);
            log('第 ${e.key + 1} 个地址结果返回稍微有点晚 -> 不是最快');
          }
        } else {
          await Future.delayed(timeout);
          log('第 ${e.key + 1} 个地址获取配置失败 -> ${request.statusCode}');
        }
      } catch (error) {
        await Future.delayed(timeout);
        log('第 ${e.key + 1} 个地址获取配置发生了错误 -> $error');
      }
    }));

    dio.close();
    return result;
  }
}

enum Environment {
  test,
  pre,
  rel,
  grey,
}
