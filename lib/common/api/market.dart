part of 'api.dart';

class _Market {
  final String getMarketList = '/market/list';
  final String buy = '/market/buy';
  final String getSubOrderInfo = '/market/getSubOrderDetail';
  final String getStatus = '/market/getStatus';
  final String cancelSubOrder = '/market/cancelPaymentOrder';
  final String uploadPayPic = '/market/uploadPayPic';
  final String getOrderSetting = '/market/getOrderSetting';
  final String sellCoin = '/market/sellLimit';
  final String changeCard = '/market/changePaymentMethod';
  final String getHistoryBuy = '/market/myOrderRecord';
  final String getHistorySell = '/market/myList';
  final String getMarketOrderInfo = '/market/getOrders';
  final String confirmOrder = '/market/confirmOrder';
  final String cancelOrder = '/market/cancelSellLimit';
  final String cancelConfirmOrder = '/market/cancelConfirmOrder';
  final String passDelay = '/market/delaySuccess';
  final String pass = '/market/success';
  final String changePay = '/market/approveChange';
  final String quicklyBuyCoins = '/market/quickDeal';
  final String getPopupNotice = '/market/getPopupNotice';
  final String getScrollNotice = '/market/getScrollNotice';
  final String getPendingOrder = '/market/getPendingOrder';
}