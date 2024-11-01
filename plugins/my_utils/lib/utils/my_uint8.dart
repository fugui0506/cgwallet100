import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
      throw ArgumentError('Unsupported input type');
    }

    // 使用 Gzip 压缩字符串
    List<int> stringBytes = utf8.encode(jsonString);
    List<int> compressedBytes = gzip.encode(stringBytes);

    return Uint8List.fromList(compressedBytes);
  }

  /// 二进制数组转字符串
  static String decode(Uint8List data) {
    // 尝试解压缩数据
    List<int> decompressedData = zlib.decode(data);
    String jsonString = utf8.decode(decompressedData);
    // Map<String,dynamic> jsonData = json.decode(jsonString);

    // 将解压缩后的数据转换为字符串
    return jsonString;
  }
}