import 'dart:convert';
import 'dart:developer';

class MyLogger {
  static final List<String> _logQueue = [];
  static bool _isLogging = false;

  static void _processLogQueue() async {
    if (_isLogging) return;
    _isLogging = true;
    while (_logQueue.isNotEmpty) {
      final logMessage = _logQueue.removeAt(0);
      log(logMessage);
      await Future.delayed(const Duration(milliseconds: 50));
    }
    _isLogging = false;
  }

  static void l() {
    _logQueue.add('-' * 120);
    _processLogQueue();
  }

  static void w(String text) {
    try {
      final jsonData = jsonDecode(text);
      String formattedJson = const JsonEncoder.withIndent('  ').convert(jsonData);
      _logQueue.add('=> $formattedJson');
    } catch (_) {
      _logQueue.add('=> $text');
      _processLogQueue();
    }
  }

  static void h({
    required bool isSuccess,
    required String type,
    required String path,
    required String headers,
    required String parameters,
    required String data,
    required String code,
    required String msg,
  }) {
    final logo = isSuccess? '✅' : '❌';
    l();
    w('$logo $type: $path');
    w('$logo 请求头: $headers');
    w('$logo 请求参数: $parameters');
    w('$logo code: $code');
    w('$logo msg: $msg');
    w("$logo data: $data");
  }
}
