part of 'api.dart';

class _Category {
  // 获取收款类型
  final String getCategoryTypeList = '/category/getAllCategory';
  // 获取默认银行卡列表
  final String getBankDefaultList = '/accountCollect/get';
  // 获取所有的银行卡列表
  final String getBankAllList = '/accountCollect/getAll';
  // 删除银行卡
  final String deleteBank = '/accountCollect/del';
  // 设置默认
  final String setDefault = '/accountCollect/setDefault';
  // 获取所有的银行卡信息
  final String getBankNameInfo = '/bank/getBankNameInfo';
  // 新增银行卡
  final String addBank = '/accountCollect/add';
}