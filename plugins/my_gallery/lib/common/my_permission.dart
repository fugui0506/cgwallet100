import 'package:permission_handler/permission_handler.dart';

class MyPermission {
  static final MyPermission _instance = MyPermission._internal();
  MyPermission._internal();
  static MyPermission get instance => _instance;

  /// 请求外部储存的读取和写入权限
  Future<bool> storage() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var result = await Permission.storage.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }

  /// 请求外部储存的读取和写入权限
  Future<bool> camera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      var result = await Permission.camera.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }

  /// 请求相册权限
  Future<bool> photos() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      var result = await Permission.photos.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }
}