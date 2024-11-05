import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_utils_platform_interface.dart';

/// An implementation of [MyUtilsPlatform] that uses method channels.
class MethodChannelMyUtils extends MyUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_utils');
}
