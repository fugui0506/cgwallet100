import 'dart:async';
import 'dart:developer';

import 'package:cgwallet/common/widgets/my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_widgets/my_widgets.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

ShorebirdUpdater? _updater;
Timer? _timer;

void startCheckingForHotUpdates(void Function()? onUpdate) {
  _timer?.cancel();
  _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
    log('正在检查热更新...');
    showMySnack(
      child: Text('正在检查热更新...')
    );
    _updater ??= ShorebirdUpdater();
    final status = await _updater!.checkForUpdate();
    if (status == UpdateStatus.outdated) {
      await _updater!.update();
      log('已检查到新版本...');
      onUpdate?.call();
    }
  });
}

void stopCheckingForHotUpdates() {
  _timer?.cancel();
}