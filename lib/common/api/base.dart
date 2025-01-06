part of 'api.dart';

class _Base {
  // 手机号登陆
  final String phoneLogin = '/base/phoneLogin';
  // 账号登陆
  final String accountLogin = '/base/accountLogin';
  // 退出登录
  final String logout = '/base/logout';
  // 获取图形验证码
  final String captcha = '/base/captcha';
  // 发送验证码
  final String sendSms = '/base/sendSms';
  // 注册
  final String register = '/base/register';
  // 忘记密码
  final String forgetPassword = '/base/forgetPassword';
  // 获取用户信息
  final String getUserInfo = '/base/getMemberInfo';
  // 修改头像
  final String editAvatar = '/base/editAvatar';
  // 修改昵称
  final String editNickname = '/base/editNickname';
  // 修改登录密码
  final String changePassword = '/base/changePassword';
  // 修改资金密码
  final String changeTransPassword = '/base/changeTransPassword';
  // 是否设置资金密码
  final String isSetTransPassword = '/base/verifyTransPassword';
  // 设置资金密码
  final String setTransPassword = '/base/setTransPassword';
  // 验证token是否有效
  final String checkToken = '/base/checkToken';
  // 获取人机验证key
  final String getCaptchaKey = '/base/choice';
}