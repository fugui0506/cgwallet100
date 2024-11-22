import 'package:permission_handler/permission_handler.dart';

class MyPermission {
  static final MyPermission _instance = MyPermission._internal();
  factory MyPermission() => _instance;
  MyPermission._internal();


  static Future<bool> storage() => _instance._storage();
  static Future<bool> camera() => _instance._camera();
  static Future<bool> photos() => _instance._photos();


  /// 请求外部储存的读取和写入权限
  Future<bool> _storage() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var result = await Permission.storage.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }

  /// 请求外部储存的读取和写入权限
  Future<bool> _camera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      var result = await Permission.camera.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }

  /// 请求相册权限
  Future<bool> _photos() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      var result = await Permission.photos.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }
}