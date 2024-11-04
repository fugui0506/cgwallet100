import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:archive/archive.dart';

class MyUint8 {
  /// 字符串转二进制数组
  static Uint8List encode(dynamic data) {
    String jsonString;

    // 根据输入类型转换为 JSON 字符串
    if (data is Map || data is List) {
      jsonString = jsonEncode(data);
    } else if (data is int || data is double || data is bool) {
      jsonString = data.toString();
    } else if (data is String) {
      jsonString = data;
    } else {
      jsonString = '$data';
    }

    try {
      List<int> stringBytes = utf8.encode(jsonString);
      List<int>? compressedBytes = GZipEncoder().encode(stringBytes);
      return Uint8List.fromList(compressedBytes ?? []);
    } catch (e) {
      log('二进制压缩失败 --> $e');
      return Uint8List.fromList([]);
    }
  }

  /// 二进制数组转字符串
  static String decode(dynamic data) {
    try {
      final bytes = List<int>.from(data);
      List<int> decompressedData = GZipDecoder().decodeBytes(bytes);
      String jsonString = utf8.decode(decompressedData);
      return jsonString;
    } catch (e) {
      log('二进制解压缩失败 --> $e');
      return '';
    }
  }
}