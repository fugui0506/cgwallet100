import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

class MyEnvironment {
  static final MyEnvironment _instance = MyEnvironment._privateConstructor();
  MyEnvironment._privateConstructor();

  static MyEnvironment get instance => _instance;

  Future<Environment> initialize() async {
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

  Future<String> getConfig(List<String> urls) async {
    final HttpClient httpClient = HttpClient();
    final Duration timeout = Duration(seconds: 10);

    String result = '';

    await Future.any(urls.asMap().entries.map((e) async {
      log('正在获取第 ${e.key + 1} 个地址的配置 -> ${e.value}');
      try {
        final HttpClientRequest request = await httpClient.getUrl(Uri.parse(e.value));
        final HttpClientResponse response = await request.close().timeout(timeout);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          final String responseBody = await response.transform(utf8.decoder).join();
          if (result.isEmpty) {
            result = responseBody;
            log('第 ${e.key + 1} 个地址获取配置成功 -> $responseBody');
          } else {
            // await Future.delayed(timeout);
            log('第 ${e.key + 1} 个地址结果返回稍微有点晚 -> 不是最快');
          }
        } else {
          // await Future.delayed(timeout);
          log('第 ${e.key + 1} 个地址获取配置失败 -> ${response.statusCode}');
        }
      } catch (error) {
        // await Future.delayed(timeout);
        log('第 ${e.key + 1} 个地址获取配置发生了错误 -> $error');
      }
    }));
    httpClient.close();
    return result;
  }
}

enum Environment {
  test,
  pre,
  rel,
  grey,
}
