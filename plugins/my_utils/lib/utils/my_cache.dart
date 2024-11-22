import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyCache {
  static final MyCache _instance = MyCache._internal();
  factory MyCache() => _instance;
  MyCache._internal() {
    const String cacheManagerKey = 'my_cache_manager_key';
    cacheManager = CacheManager(Config(
      cacheManagerKey,
      stalePeriod: _timeCache,
    ));
  }

  static Future<File?> getSingleFile(String url) => _instance._getSingleFile(url);
  static Future<File?> getFile(String url) => _instance._getFile(url);
  static Future<void> putFile(String key, String data, {Duration maxAge = _timeCache}) => _instance._putFile(key, data, maxAge: maxAge);
  static Future<void> removeFile(String url) => _instance._removeFile(url);
  static Future<void> clear() => _instance._clear();

  late BaseCacheManager cacheManager;
  static const Duration _timeCache = Duration(days: 1);

  Future<File?> _getSingleFile(String url) async {
    try {
      final file = await cacheManager.getSingleFile(url);
      log('获取缓存文件成功$url -> ${file.path}');
      return file;
    } catch (e) {
      log('获取单个文件时出错 -> $e');
      return null;
    }
  }

  Future<File?> _getFile(String url) async {
    final fileInfo = await cacheManager.getFileFromCache(url);
    if (fileInfo == null) {
      log('没有找到缓存文件 -> $url');
    } else {
      final validTill = fileInfo.validTill;
      final isBefore = validTill.isBefore(DateTime.now());
      log('缓存过期时间: $validTill  -> 是否过期: $isBefore');
      if (isBefore) {
        await cacheManager.removeFile(url);
        return null;
      }
    }
    return fileInfo?.file;
  }

  Future<void> _putFile(String key, String data, {
    Duration maxAge = _timeCache,
  }) async {
    try {
      Uint8List uint8list = Uint8List.fromList(utf8.encode(data));
      await cacheManager.putFile(key, uint8list,
        key: key,
        maxAge: maxAge,
      );
      log('成功缓存文件 -> $key');
    } catch (e) {
      log('缓存文件时出错 -> $e');
    }
  }

  Future<void> _removeFile(String url) async {
    try {
      await cacheManager.removeFile(url);
      log('成功删除缓存文件 -> $url');
    } catch (e) {
      log('删除缓存文件时出错 -> $e');
    }
  }

  Future<void> _clear() async {
    try {
      await cacheManager.emptyCache();
      log('缓存已清空');
    } catch (e) {
      log('清空缓存时出错 -> $e');
    }
  }
}