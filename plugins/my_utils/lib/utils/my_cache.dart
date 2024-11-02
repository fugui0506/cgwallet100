import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyCache {
  // static final MyCache _instance = MyCache._privateConstructor();
  // MyCache._privateConstructor();
  // static MyCache get to => _instance;

  final String cacheManagerKey;
  final Duration timeCache;

  late BaseCacheManager cacheManager;

  MyCache({
    required this.cacheManagerKey,
    required this.timeCache,
  }) {
    cacheManager = CacheManager(Config(cacheManagerKey,
      stalePeriod: timeCache,
    ));
  }

  Future<File?> getSingleFile(String url) async {
    final file = await cacheManager.getSingleFile(url);
    return file;
  }

  Future<File?> getFile(String url) async {
    final fileInfo = await cacheManager.getFileFromCache(url);
    if (fileInfo == null) {
      log('没有找到缓存文件 -> $url');
    } else {
      log('已找到缓存文件 -> ${fileInfo.file.path}');
    }
    return fileInfo?.file;
  }

  Future<void> putFile(String url, String json) async {
    Uint8List uint8list = Uint8List.fromList(utf8.encode(json));
    await cacheManager.putFile(url, uint8list);
  }
}