import 'package:shorebird_code_push/shorebird_code_push.dart';

final _updater = ShorebirdUpdater();

Future<void> checkForHotUpdates({
  bool isReCheck = false,
  void Function()? onNext
}) async {
  final status = await _updater.checkForUpdate();
  if (status == UpdateStatus.outdated) {
    await _updater.update();
    onNext?.call();
  } else {
    if (isReCheck) {
      await Future.delayed(Duration(minutes: 2));
      checkForHotUpdates(isReCheck: isReCheck, onNext: onNext);
    } else {
      onNext?.call();
    }
  }
}