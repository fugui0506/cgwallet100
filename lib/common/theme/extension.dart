part of 'theme.dart';

extension ThemeExtension on ThemeData {
  MyColors get myColors => MyColors();
  MyStyles get myStyles => MyStyles(myColors: myColors);
  MyIcons get myIcons => MyIcons(myColors: myColors);
}