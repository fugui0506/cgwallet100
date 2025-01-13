part of 'theme.dart';

class MyStyles {
  static final MyStyles _instance = MyStyles._internal();
  factory MyStyles() => _instance;
  MyStyles._internal();

  MyColors get _myColors => MyColors();

  TextStyle get inputHint => TextStyle(color: _myColors.inputHint, fontSize: 14);
  TextStyle get inputText => TextStyle(color: _myColors.inputText, fontSize: 14);
  TextStyle get inputError => TextStyle(color: _myColors.error, fontSize: 14);
  TextStyle get inputBankTitle => TextStyle(color: _myColors.inputText, fontSize: 14);

  TextStyle get label => TextStyle(color: _myColors.textDefault, fontSize: 14, height: 0);
  TextStyle get labelSmall => TextStyle(color: _myColors.textDefault.withValues(alpha: 0.6), fontSize: 14, height: 0);
  TextStyle get labelBig => TextStyle(color: _myColors.textDefault, fontSize: 16, height: 0);
  TextStyle get labelBigger => TextStyle(color: _myColors.textDefault, fontSize: 18, height: 0);
  TextStyle get labelBiggest => TextStyle(color: _myColors.textDefault, fontSize: 22, height: 0);

  TextStyle get labelPrimary => TextStyle(color: _myColors.primary, fontSize: 14, height: 0);
  TextStyle get labelPrimaryBig => TextStyle(color: _myColors.primary, fontSize: 16, height: 0);
  TextStyle get labelPrimaryBigger => TextStyle(color: _myColors.primary, fontSize: 18, height: 0);
  TextStyle get labelPrimaryBiggest => TextStyle(color: _myColors.primary, fontSize: 22, height: 0);

  TextStyle get labelRed => TextStyle(color: _myColors.error, fontSize: 14);
  TextStyle get labelRedBig => TextStyle(color: _myColors.error, fontSize: 16);
  TextStyle get labelRedBigger => TextStyle(color: _myColors.error, fontSize: 18);
  TextStyle get labelGreen => TextStyle(color: _myColors.secondary, fontSize: 14);
  TextStyle get labelGreenBig => TextStyle(color: _myColors.secondary, fontSize: 16);
  TextStyle get labelGreenBigger => TextStyle(color: _myColors.secondary, fontSize: 18);

  TextStyle get labelLight => TextStyle(color: _myColors.light, fontSize: 14, height: 0);
  TextStyle get labelLightBig => TextStyle(color: _myColors.light, fontSize: 16, height: 0);
  TextStyle get labelLightBigger => TextStyle(color: _myColors.light, fontSize: 18, height: 0);
  TextStyle get labelLightBiggest => TextStyle(color: _myColors.light, fontSize: 22, height: 0);

  TextStyle get content => TextStyle(color: _myColors.textDefault, fontSize: 14, height: 1.5);
  TextStyle get contentLight => TextStyle(color: _myColors.light, fontSize: 14, height: 1.5);
  TextStyle get contentSmall => TextStyle(color: _myColors.textDefault.withValues(alpha: 0.6), fontSize: 14, height: 1.5);
  TextStyle get contentBig => TextStyle(color: _myColors.textDefault, fontSize: 16, height: 1.5);
  TextStyle get contentBigger => TextStyle(color: _myColors.textDefault, fontSize: 18, height: 1.5);
  TextStyle get contentBiggest => TextStyle(color: _myColors.textDefault, fontSize: 22, height: 1.5);

  // appBar的文字样式
  TextStyle get appBarTitle => TextStyle(color: _myColors.onaAppBar, fontSize: 18);
  IconThemeData get appBarIconThemeData => IconThemeData(color: _myColors.onaAppBar, size: 18);

  TextStyle get buttonText => const TextStyle(fontSize: 14);

  // 长按钮的样式
  ButtonStyle getButtonFilledLong({Color? textColor, Color? buttonColor, double? radius}) => ButtonStyle(
    textStyle: WidgetStateProperty.all<TextStyle?>(buttonText),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return _myColors.buttonPressed;
      if (states.contains(WidgetState.disabled)) return _myColors.buttonDisable;
      return buttonColor ?? _myColors.primary;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return _myColors.onPrimary;
      if (states.contains(WidgetState.disabled)) return _myColors.onButtonDisable;
      return textColor ?? _myColors.onPrimary;
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
      if (states.contains(WidgetState.pressed)) return _myColors.buttonPressed;
      if (states.contains(WidgetState.disabled)) return _myColors.buttonDisable;
      return buttonColor ?? _myColors.primary;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return _myColors.onButtonDisable;
      return textColor ?? _myColors.onPrimary;
    }),
    shape: WidgetStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),),
  );

  // 文字按钮的样式
  ButtonStyle getButtonText({Color? textColor, double? fontSize, double? radius}) => TextButton.styleFrom(
    textStyle: TextStyle(
      fontSize: fontSize ?? 14,
      height: 0
    ),
    foregroundColor: textColor ?? _myColors.onBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),
  );
}
