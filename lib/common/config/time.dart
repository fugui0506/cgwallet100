part of 'config.dart';

class _Time {
  // 请求超时时间-获取配置
  final Duration outCheck = const Duration(seconds: 10);
  // 请求超时默认
  final Duration outDefault = const Duration(minutes: 60);
  // 等待时间
  final Duration wait = const Duration(seconds: 2);
  // 心跳间隔
  final Duration heartbeat = const Duration(seconds: 10);
  // 重连间隔的基数
  final Duration retry = const Duration(seconds: 1);
  // 页面切换动画时长
  final Duration pageTransition = const Duration(milliseconds: 300);
  // 冷却时长
  final Duration cooling = const Duration(milliseconds: 100);
  // 防抖时长
  final Duration debounce = const Duration(seconds: 1);
  // 缓存时间
  final Duration cache = const Duration(days: 1);
}