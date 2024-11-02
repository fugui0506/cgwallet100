import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';

extension StringExtension on String {
  /// 加密字符串
  String aesEncrypt(String keyStr) {
    final key = Key.fromUtf8(keyStr);
    final iv = IV.fromLength(16);
    final encrypt = Encrypter(AES(
      key,
      mode: AESMode.ecb,
      padding: 'PKCS7',
    ));
    final encrypted = <String>[];

    const chunkSize = 256;
    for (int i = 0; i < length; i += chunkSize) {
      final chunk = substring(i, i + chunkSize > length ? length : i + chunkSize);
      final encryptedChunk = encrypt.encrypt(chunk, iv: iv).base64;
      encrypted.add(encryptedChunk);
    }

    return encrypted.join(':::');
  }

  /// 解密字符串
  String aesDecrypt(String keyStr) {
    if (isEmpty) return '';

    final key = Key.fromUtf8(keyStr);
    final iv = IV.fromLength(16);
    final encrypt = Encrypter(AES(
      key,
      mode: AESMode.ecb,
      padding: 'PKCS7',
    ));

    return split(':::').map((chunk) => encrypt.decrypt64(chunk, iv: iv)).join();
  }

  /// 校验中文名字
  bool isChineseName() => RegExp(r'^[\u4e00-\u9fa5·]{2,20}$').hasMatch(this);

  /// 保留小数位
  String fixed(int fractionDigits) {
    if (!isNumber()) return this;

    if (fractionDigits <= 0) {
      return split('.').first;
    }

    int dotIndex = indexOf('.');

    if (dotIndex == -1) {
      return '$this.${'0' * fractionDigits}';
    } else {
      int decimalLength = length - dotIndex - 1;
      if (decimalLength >= fractionDigits) {
        return substring(0, dotIndex + fractionDigits + 1);
      } else {
        return this + '0' * (fractionDigits - decimalLength);
      }
    }
  }

  /// 格式化 JSON
  String format() {
    try {
      final jsonData = jsonDecode(this);
      String formattedJson = const JsonEncoder.withIndent('  ').convert(jsonData);
      return formattedJson;
    } catch (_) {
      return this;
    }
  }

  /// 格式化 JSON
  dynamic toJson() {
    try {
      final jsonData = jsonDecode(this);
      return jsonData;
    } catch (_) {
      return this;
    }
  }

  /// 校验身份证
  bool isChineseID() {
    final RegExp regex18 = RegExp(r'^\d{6}(18|19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dXx]$');
    final RegExp regex15 = RegExp(r'^\d{6}\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}$');

    if (regex18.hasMatch(this)) {
      if (length != 18) return false;

      final List<int> weights = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
      final List<String> checkDigits = ['1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'];

      int sum = 0;
      for (int i = 0; i < 17; i++) {
        sum += int.parse(this[i]) * weights[i];
      }

      int mod = sum % 11;
      String expectedCheckDigit = checkDigits[mod];
      String actualCheckDigit = this[17].toUpperCase();

      return expectedCheckDigit == actualCheckDigit;
    } else if (regex15.hasMatch(this)) {
      return true;
    } else {
      return false;
    }
  }

  /// 隐藏中间字符串的中间部分
  String hideMiddle(int keepStartLength, int keepEndLength) {
    final keepStart = keepStartLength < 0 ? 0 : keepStartLength;
    final keepEnd = keepEndLength < 0 ? 0 : keepEndLength;

    if (length <= keepStart + keepEnd) {
      // 如果字符串长度小于或等于要显示的字符总数，则不做处理
      return this;
    }

    String start = substring(0, keepStart);
    String end = substring(length - keepEnd);
    String ellipsis = List.filled(length - keepStart - keepEnd, '*').join();
    return '$start$ellipsis$end';
  }

  /// 手机号验证
  bool isChinaPhone() => RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|66|7[0135678]|9[89])\d{8}$").hasMatch(this);

  /// 纯数字验证
  bool isNumber() => RegExp(r"^\d+(\.\d+)?$").hasMatch(this);

  /// 邮箱验证
  bool isEmail() => RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$").hasMatch(this);

  /// 验证URL
  bool isUrl() => RegExp(r"^((https|http|ftp|rtsp|mms)?://)\S+").hasMatch(this);

  /// 验证中文
  bool isChinese() => RegExp(r"[\u4e00-\u9fa5]").hasMatch(this);

  /// 匹配中文，英文字母
  bool isChar() => RegExp(r"^[a-zA-Z0-9_\u4e00-\u9fa5]+$").hasMatch(this);

  /// 验证码密码：8-16位，至少包含一个字母一个数字，其他不限制
  bool isPassword() => RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[^]{8,16}$").hasMatch(this);

  /// 验证用户名 6-16位 字母开头，可以包含数字和下划线
  bool isUserName() => RegExp(r"^[a-zA-Z]\w{5,15}$").hasMatch(this);

  /// 复制字符串到粘贴板
  Future<void> copyToClipBoard() async {
    await Clipboard.setData(ClipboardData(text: this));
  }

  /// 去除html标签
  String removeHtmlTags() {
    final RegExp regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return replaceAll(regExp, '');
  }
}
