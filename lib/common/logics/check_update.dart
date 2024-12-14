import 'dart:async';
import 'dart:developer';

import 'package:shorebird_code_push/shorebird_code_push.dart';

ShorebirdUpdater? _updater;
Timer? _timer;

void startCheckingForHotUpdates(void Function()? onUpdate) {
  _timer?.cancel();
  _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
    _updater ??= ShorebirdUpdater();
    final status = await _updater!.checkForUpdate();
    if (status == UpdateStatus.outdated) {
      await _updater!.update();
      onUpdate?.call();
    }
    log('正在检查热更新...');
  });
}

void stopCheckingForHotUpdates() {
  _timer?.cancel();
}