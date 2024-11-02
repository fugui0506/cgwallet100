part of 'api.dart';

class _Swap {
  // 获取闪兑配置
  final String getSwapSetting = '/swap/getSwapSetting';
  // 创建闪兑订单
  final String createSwapOrder = '/swap/createSwapOrder';
  // 获取闪兑记录
  final String getSwapOrderList = '/swap/getSwapRecord';
  final String getSwapOrderInfo = '/swap/getSwapDetails';
  final String pay = '/swap/confirmAlreadySwapped';
}