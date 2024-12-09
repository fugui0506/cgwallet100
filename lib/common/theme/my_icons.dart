part of 'theme.dart';
class MyIcons {
  static final MyIcons _instance = MyIcons._internal();
  factory MyIcons() => _instance;
  MyIcons._internal();

  MyColors get _myColors => MyColors();

  Icon get right => Icon(Icons.chevron_right, color: _myColors.iconGrey);
  Icon get brokenImage => Icon(Icons.broken_image, size: 64, color: _myColors.textDefault);
  Icon get done => Icon(Icons.done, color: _myColors.textDefault, size: 16);
  Icon get downSolid => Icon(Icons.arrow_drop_down, color: _myColors.textDefault);
  Icon get downSolidLight => Icon(Icons.arrow_drop_down, color: _myColors.onButtonPressed);
  Icon get upSolid => Icon(Icons.arrow_drop_up, color: _myColors.textDefault);
  Icon get upSolidPrimary => Icon(Icons.arrow_drop_up, color: _myColors.primary);
  Icon get up => Icon(Icons.keyboard_control_key, color: _myColors.textDefault);
  Icon get upPrimary => Icon(Icons.keyboard_control_key, color: _myColors.primary);
  Icon get down => Icon(Icons.keyboard_arrow_down, color: _myColors.textDefault);
  Icon get downPrimary => Icon(Icons.keyboard_arrow_down, color: _myColors.primary);
  Icon get theme => Icon(Icons.dark_mode, color: _myColors.textDefault);
  Icon get language => Icon(Icons.language, color: _myColors.textDefault);
  Icon get audio => Icon(Icons.volume_up, color: _myColors.textDefault);
  Icon get vibration => Icon(Icons.vibration, color: _myColors.textDefault);
  Icon get themeLight => Icon(Icons.light_mode, color: _myColors.textDefault);
  Icon get themeDark => Icon(Icons.dark_mode, color: _myColors.textDefault);
  Icon get themeSystem => Icon(Icons.contrast, color: _myColors.textDefault);
  Icon get add => Icon(Icons.add, color: _myColors.iconDefault);
  Icon get checkLight => Icon(Icons.check, color: _myColors.light);
  Icon get deleteLight => Icon(Icons.delete_forever, color: _myColors.light);
  Icon get filter => Icon(Icons.filter_alt_outlined, color: _myColors.textDefault);
  Icon get checkBox => Icon(Icons.check_box, color: _myColors.inputSuffixIcon);
  Icon get checkBoxPrimary => Icon(Icons.check_box, color: _myColors.primary);
  Icon get help => Icon(Icons.question_mark, color: _myColors.iconDefault);

  Icon get qiEmoticons => Icon(Icons.mood, color: _myColors.iconDefault);
  Icon get qiCameraIcon => Icon(Icons.photo_camera, color: _myColors.iconDefault);
  Icon get qiImage => Icon(Icons.image, color: _myColors.iconDefault);
  Icon get qiKeyboard => Icon(Icons.keyboard, color: _myColors.iconDefault);
  Icon get qiVideo => Icon(Icons.videocam, color: _myColors.iconDefault);
  Icon get qiError => Icon(Icons.error, color: _myColors.error);
}