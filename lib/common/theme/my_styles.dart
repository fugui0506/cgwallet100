part of 'theme.dart';

class MyStyles {
  MyStyles({required this.myColors});
  final MyColors myColors;

  // 输入框的 hintText 样式
  TextStyle get inputHint => TextStyle(color: myColors.inputHint, fontSize: 14);
  // 输入框文本的样式
  TextStyle get inputText => TextStyle(color: myColors.inputText, fontSize: 14);
  // 输入框文本的样式
  TextStyle get inputError => TextStyle(color: myColors.error, fontSize: 14);
  TextStyle get inputBankTitle => TextStyle(color: myColors.inputText, fontSize: 14);

  // 登录页面Title
  TextStyle get loginTitleSelect => TextStyle(color: myColors.primary, fontSize: 16);
  TextStyle get loginPasswordTitle => TextStyle(color: myColors.primary, fontSize: 18);
  TextStyle get loginTitleUnselect => TextStyle(color: myColors.primary, fontSize: 16);

  // 高度是0的Label样式
  TextStyle get label => TextStyle(color: myColors.textDefault, fontSize: 14, height: 0);
  TextStyle get labelSmall => TextStyle(color: myColors.textDefault.withOpacity(0.6), fontSize: 14, height: 0);
  TextStyle get labelBig => TextStyle(color: myColors.textDefault, fontSize: 16, height: 0);
  TextStyle get labelBigger => TextStyle(color: myColors.textDefault, fontSize: 18, height: 0);
  TextStyle get labelBiggest => TextStyle(color: myColors.textDefault, fontSize: 22, height: 0);

  TextStyle get labelPrimary => TextStyle(color: myColors.primary, fontSize: 14, height: 0);
  TextStyle get labelPrimaryBig => TextStyle(color: myColors.primary, fontSize: 16, height: 0);
  TextStyle get labelPrimaryBigger => TextStyle(color: myColors.primary, fontSize: 18, height: 0);
  TextStyle get labelPrimaryBiggest => TextStyle(color: myColors.primary, fontSize: 22, height: 0);

  TextStyle get labelRed => TextStyle(color: myColors.error, fontSize: 14);
  TextStyle get labelRedBig => TextStyle(color: myColors.error, fontSize: 16);
  TextStyle get labelRedBigger => TextStyle(color: myColors.error, fontSize: 18);
  TextStyle get labelGreen => TextStyle(color: myColors.secondary, fontSize: 14);
  TextStyle get labelGreenBig => TextStyle(color: myColors.secondary, fontSize: 16);
  TextStyle get labelGreenBigger => TextStyle(color: myColors.secondary, fontSize: 18);

  TextStyle get labelLight => TextStyle(color: myColors.light, fontSize: 14, height: 0);
  TextStyle get labelLightBig => TextStyle(color: myColors.light, fontSize: 16, height: 0);
  TextStyle get labelLightBigger => TextStyle(color: myColors.light, fontSize: 18, height: 0);
  TextStyle get labelLightBiggest => TextStyle(color: myColors.light, fontSize: 22, height: 0);

  TextStyle get content => TextStyle(color: myColors.textDefault, fontSize: 14, height: 1.5);
  TextStyle get contentLight => TextStyle(color: myColors.light, fontSize: 14, height: 1.5);
  TextStyle get contentSmall => TextStyle(color: myColors.textDefault.withOpacity(0.6), fontSize: 14, height: 1.5);
  TextStyle get contentBig => TextStyle(color: myColors.textDefault, fontSize: 16, height: 1.5);
  TextStyle get contentBigger => TextStyle(color: myColors.textDefault, fontSize: 18, height: 1.5);
  TextStyle get contentBiggest => TextStyle(color: myColors.textDefault, fontSize: 22, height: 1.5);

  TextStyle get mineViewTutorialTitle => TextStyle(color: myColors.primary, fontSize: 22);

  // faq 标题
  TextStyle get faqTitle => TextStyle(color: myColors.textDefault, fontSize: 15, height: 0);
  TextStyle get faqContent => TextStyle(color: myColors.textDefault.withOpacity(0.6), fontSize: 14);
  TextStyle get faqViewTitle => TextStyle(color: myColors.primary, fontSize: 18, height: 0);

  TextStyle get flashViewTitle => TextStyle(color: myColors.textDefault, fontSize: 22, height: 0);

  // appBar的文字样式
  TextStyle get appBarTitle => TextStyle(color: myColors.onaAppBar, fontSize: 18);
  // appBar的图标样式
  IconThemeData get appBarIconThemeData => IconThemeData(color: myColors.onaAppBar, size: 18);

  // appBar的文字样式
  TextStyle get dialogTitle => TextStyle(color: myColors.onDialogBackground, fontSize: 18);
  // appBar的图标样式
  IconThemeData get dialogMessage => IconThemeData(color: myColors.onDialogBackground, size: 14);

  // snackBar 文字样式
  TextStyle get onSnackBar => TextStyle(color: myColors.background, fontSize: 14);

  // 首页 AppBar 上面的文字
  TextStyle get onHomeAppBarNormal => TextStyle(color: myColors.onPrimary, fontSize: 14, height: 0);
  TextStyle get onHomeAppBarUID => TextStyle(color: myColors.onPrimary, fontSize: 16);
  TextStyle get onHomeAppBarHeader => TextStyle(color: myColors.onPrimary, fontSize: 18, height: 0);
  TextStyle get onHomeAppBarBigger => TextStyle(color: myColors.onPrimary, fontSize: 22, height: 0);
  TextStyle get homeQuickBuyTitle => TextStyle(color: myColors.primary, fontSize: 18, height: 0);

  TextStyle get onButton => TextStyle(color: myColors.onPrimary, fontSize: 14);
  TextStyle get offline => TextStyle(color: myColors.buttonDisable, fontSize: 14);

  // 按钮文字的样式
  TextStyle get buttonText => const TextStyle(fontSize: 14);

  // 底部导航栏的文字样式
  TextStyle get bottomSelect => TextStyle(fontSize: 12, color: myColors.primary, height: 0);
  TextStyle get bottomUnselect => TextStyle(fontSize: 12, color: myColors.textBottomUnselect, height: 0);

  // 长按钮的样式
  ButtonStyle getButtonFilledLong({Color? textColor, Color? buttonColor, double? radius}) => ButtonStyle(
    textStyle: WidgetStateProperty.all<TextStyle?>(buttonText),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return myColors.buttonPressed;
      if (states.contains(WidgetState.disabled)) return myColors.buttonDisable;
      return buttonColor ?? myColors.primary;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return myColors.onPrimary;
      if (states.contains(WidgetState.disabled)) return myColors.onButtonDisable;
      return textColor ?? myColors.onPrimary;
    }),
    minimumSize: WidgetStateProperty.all<Size>(const Size(double.infinity, 40)),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
    ),
  );

  // 短按钮的样式
  ButtonStyle getButtonFilledShort({Color? textColor, Color? buttonColor, double? radius}) => ButtonStyle(
    textStyle: WidgetStateProperty.all<TextStyle?>(buttonText),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return myColors.buttonPressed;
      if (states.contains(WidgetState.disabled)) return myColors.buttonDisable;
      return buttonColor ?? myColors.primary;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return myColors.onButtonDisable;
      return textColor ?? myColors.onPrimary;
    }),
    shape: WidgetStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),),
  );

  // 文字按钮的样式
  ButtonStyle getButtonText({Color? textColor, double? fontSize, double? radius}) => TextButton.styleFrom(
    textStyle: TextStyle(
      fontSize: fontSize ?? 14,
      height: 0
    ),
    foregroundColor: textColor ?? myColors.onBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),
  );
}
