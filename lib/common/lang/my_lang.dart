import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

part 'lang_keys.dart';
part 'key_en.dart';
part 'key_zh.dart';

class MyLang extends Translations {
  static final defaultMode = MyLangMode.zh.toLocale(); // 默认语言模式
  static final fallbackMode = MyLangMode.zh.toLocale(); // 回退语言模式

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static final supportedLocales = [
    MyLangMode.zh,
    MyLangMode.en,
  ].map((mode) => mode.toLocale()).toList();

  final _keys = {
    MyLangMode.zh.toLocaleTag(): zh,
    MyLangMode.en.toLocaleTag(): en,
  };

  @override
  Map<String, Map<String, String>> get keys => _keys;

  /// 更改语言
  static Future<void> update({
    required MyLangMode mode,
    void Function(MyLangMode mode)? onSuccess,
  }) async {
    await Get.updateLocale(mode.toLocale());
    onSuccess?.call(mode);

    log('当前APP语言：${mode.toLocale()}');
    log('当前系统语言：${Get.deviceLocale}');
  }
}

class SystemLocaleObserver with WidgetsBindingObserver {
  static SystemLocaleObserver? _instance;

  factory SystemLocaleObserver({required Future<MyLangMode?> Function() getLangMode}) {
    _instance ??= SystemLocaleObserver._internal(getLangMode: getLangMode);
    return _instance!;
  }

  SystemLocaleObserver._internal({required this.getLangMode});

  final Future<MyLangMode?> Function() getLangMode;

  static void init({required Future<MyLangMode?> Function() getLangMode}) {
    SystemLocaleObserver(getLangMode: getLangMode)._init();
  }

  void _init() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeLocales(List<Locale>? locales) async {
    final newLocale = locales?.first ?? MyLang.defaultMode;
    log("检测到系统语言发生了改变 -> $newLocale");
    
    final myLangMode = await getLangMode();
    
    if (myLangMode == null) {
      final mode = MyLangMode.fromLocale(newLocale);
      await MyLang.update(mode: mode);
      log("系统语言已更新 -> $newLocale");
    } else {
      await MyLang.update(mode: myLangMode);
      log("语言保持原样 -> ${myLangMode.toLocale()}");
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}

enum MyLangMode {
  en('en'),
  zh('zh');

  final String mode;

  const MyLangMode(this.mode);

  static MyLangMode fromString(String mode) {
    switch (mode) {
      case 'en':
        return MyLangMode.en;
      case 'zh':
        return MyLangMode.zh;
      default:
        return MyLangMode.zh;
    }
  }

  static MyLangMode fromLocale(Locale locale) {
    final languageCode = locale.languageCode;
    switch (languageCode) {
      case 'zh':
        return MyLangMode.zh;
      case 'en':
        return MyLangMode.en;
      default:
        return MyLangMode.zh;
    }
  }

  Locale toLocale() {
    switch (this) {
      case MyLangMode.en:
        return const Locale('en', 'US'); // English (United States)
      case MyLangMode.zh:
        return const Locale('zh', 'CN'); // Chinese (China)
    }
  }

  String toLocaleTag() {
    return '${toLocale().languageCode}_${toLocale().countryCode}';
  }

  @override
  String toString() {
    return mode;
  }
}