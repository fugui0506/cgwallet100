part of 'api.dart';

class _Me {
  // 获取未读公告的数量
  final String getUnreadCount = '/me/getUnreadCount';
  // 获取走马灯信息
  final String getMarquee = '/me/marquee';
  // 获取Carousels
  final String getCarousel = '/me/getCarousel';
  // 获取常见问题列表
  final String getFaq = '/me/getFaq';
  // 获取头像列表
  final String getAvatarList = '/me/avatarList';
  // 获取教程
  final String getTutorial = '/me/getTutorial';
  // 获取优惠活动列表
  final String getPromotions = '/me/banner/list';
  // 获取版本号
  final String getVersion = '/me/getVersion';
  // 通知列表
  final String getNotify = '/me/notice';
  // 阅读通知
  final String readNotify = '/me/noticeDetail';
  // 获取客服列表
  final String getCustomer = '/me/getChatInfo';
  // 获取公告列表
  final String getPublicNotice = '/me/getPopupNotice';
}