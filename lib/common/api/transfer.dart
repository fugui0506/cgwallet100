part of 'api.dart';

class _Transfer {
  // 获取交易类型
  final String getGeneralType = '/transfer/getTransferGeneralType';
  // 获取钱包历史记录
  final String getWalletHistory = '/transfer/walletRecord';
  // 获取转账历史记录
  final String getTransferHistory = '/transfer/getHistory';
  final String getTransferUser = '/coin/getMemberInfoByAddress';
  final String transfer = '/transfer/toCgb';
  final String pay = '/merchant/pay';
}