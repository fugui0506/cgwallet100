import 'dart:async';

import 'package:get/get.dart';
import 'package:my_utils/my_utils.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  // 初始化等待方法
  final Completer<void> _initCompleter = Completer<void>();
  Future<void> get initComplete => _initCompleter.future;

  MyDio? myDio;

  MyWss? myWss;

  List<String> baseUrlList = [];

  List<String> wssUrlList = [];

  String userToken = '';

  @override
  void onInit() async {
    super.onInit();
    _initCompleter.complete();
    MyLogger.w('UserController 初始化完毕...');
  }
}