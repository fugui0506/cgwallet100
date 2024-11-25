part of 'theme.dart';

class MyColors {
  // 主色-固定色
  Color get primary => const Color(0xFF586BF9);
  // 主色上面的颜色
  Color get onPrimary => const Color(0xFFFFFFFF);
  // 背景色 / 主题色
  Color get background => Get.isDarkMode ? const Color(0xFF151516) : const Color(0xFFF5F8FC);
  // 背景上的反色，例如文字
  Color get onBackground => Get.isDarkMode ? const Color(0xFFF5F8FC) : const Color(0xFF333334);
  // 错误的颜色
  Color get error => const Color(0xFFDF0000);
  // 待确认
  Color get onPending => const Color(0xFFFFA100);
  // 订单超时
  Color get onTimeout => const Color(0xFFB238C5);

  // 待收款
  Color get onReceiving => const Color(0xFFC56538);


  // 取消
  Color get onCancel => const Color(0xFF999999);
  // 错误颜色上面的颜色
  Color get onError => const Color(0xFFFFFFFF);
  // 错误的颜色
  Color get dark => const Color(0xFF000000);
  // 错误颜色上面的颜色
  Color get light => const Color(0xFFFFFFFF);
  // 辅助色
  Color get secondary => const Color(0xFF25A812);
  // 辅助色上面的颜色
  Color get onSecondary => const Color(0xFFFFFFFF);

  // 卡片背景颜色
  Color get cardBackground => Get.isDarkMode ? const Color(0xFF232325) : const Color(0xFFFFFFFF);
  // 卡片上的文字颜色
  Color get onCardBackground => Get.isDarkMode ? const Color(0xFFF5F8FC) : const Color(0xFF333334);
  // banner卡片的边框
  Color get carouselBorder => Get.isDarkMode ? const Color(0xFF434345) : const Color(0xFFFFFFFF);
  // loading背景颜色
  Color get loadingBackground => Get.isDarkMode ? const Color(0x53232324) : const Color(0x53232324);
  // itemCard 背景
  Color get itemCardBackground => Get.isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F7);
  Color get banksTag => Get.isDarkMode ? const Color(0xFF3D3D41) : const Color(0xFFE6E6E6);

  // 输入框边框的颜色
  Color get inputBorder => Get.isDarkMode ? const Color(0xFF434345) : const Color(0xFFD1D1D1);
  // 输入框左侧图标的颜色
  Color get inputPrefixIcon => Get.isDarkMode ? const Color(0xFFF5F8FC) : const Color(0xFF333334);
  // 输入框左侧图标的颜色
  Color get inputSuffixIcon => Get.isDarkMode ? const Color(0xFF8E8E92) : const Color(0xFFD1D1D1);
  // 输入框文字颜色
  Color get inputText => Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  // 输入框提示文本颜色
  Color get inputHint => Get.isDarkMode ? const Color(0xFF8E8E92) : const Color(0xFFD1D1D1);
  // 输入框添加银行卡
  Color get inputBank => Get.isDarkMode ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F7);
  // 输入框背景
  Color get input => Get.isDarkMode ? const Color(0x002C2C2E) : const Color(0x00F3F4F7);

  // 图标颜色
  Color get iconDefault => Get.isDarkMode ? const Color(0xFFF5F8FC) : const Color(0xFF333334);
  Color get iconGrey => Get.isDarkMode ? const Color(0xFF8E8E92) : const Color(0xFFD1D1D1);
  Color get iconCopy => Get.isDarkMode ? const Color(0xFF333334) : const Color.fromARGB(255, 161, 162, 165);

  // 文本颜色
  Color get textDefault => Get.isDarkMode ? const Color(0xFFD1D1D1) : const Color(0xFF666666);
  Color get textBottomUnselect => Get.isDarkMode ? const Color(0xFF85879A) : const Color(0xFFB7BACE);

  // 按钮禁用的背景颜色
  Color get buttonDisable => Get.isDarkMode ? const Color(0xFF4F4F53) : const Color(0xFFD1D1D1);
  // 取消按钮的背景颜色
  Color get buttonCancel => Get.isDarkMode ? const Color(0xFF4F4F53) : const Color(0xFFCBCCD0);
  // 取消按钮的文字颜色
  Color get onButtonCancel => Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  // 按钮禁用状态下的文字颜色
  Color get onButtonDisable => Get.isDarkMode ? const Color(0xFFAFAFB9) : const Color(0xFF828489);
  // 按钮按下时的背景颜色
  Color get buttonPressed =>  const Color(0xFF7800F8);
  // 按钮按下时，按钮上面的颜色
  Color get onButtonPressed =>  const Color(0xFFFFFFFF);
  // 按钮禁用的背景颜色
  Color get buttonUnselect => Get.isDarkMode ? const Color(0xFF4F4F53) : const Color(0xFFF3F4F7);
  // 按钮禁用状态下的文字颜色
  Color get onButtonUnselect => Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

  // 我的页面，编辑按钮背景色
  Color get mineViewEdit => Get.isDarkMode ? const Color(0xFFDCE0F8) : const Color(0xFFF3F4F7);

  // appBar 背景渐变色 - 起始位置
  Color get appBarGradientStart => Get.isDarkMode ? const Color(0xFF3A3A4B) : const Color(0xFFD7E2FF);
  // appBar 背景渐变色 - 终止位置
  Color get appBarGradientEnd => background;
  // appBar 上面的文字颜色
  Color get onaAppBar => Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

  // snackBar 背景色
  Color get snackBarBackground => Get.isDarkMode ? const Color(0xFF1B1B1E) : const Color(0xFFFFFFFF);
  // appBar 背景渐变色 - 终止位置
  Color get onSnackBarBackground => Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF333334);

  // 弹窗背景色
  Color get dialogBackground => Get.isDarkMode ? const Color(0xFFF5F8FC) : const Color(0xFF333334);
  // 弹窗文字颜色
  Color get onDialogBackground => Get.isDarkMode ? const Color(0xFF333334) : const Color(0xFFF5F8FC);

  // 底部导航栏的背景颜色
  Color get bottomNavigationBackground => Get.isDarkMode ? const Color(0xFF1F1F21) : const Color(0xFFFFFFFF);
}
