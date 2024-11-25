import 'package:flutter/widgets.dart';
import 'package:get/get.dart';



/// 第一次欢迎页面
class MiddlewareIndex extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // if (UserController.to.isUsedApp.isEmpty) {
    //   return null;
    // }
    // if (UserController.to.userInfo.value.token.isNotEmpty) {
    //   return const RouteSettings(name: MyRoutes.frameView);
    // }
    // return const RouteSettings(name: MyRoutes.loginView);

    return null;
  }
}
