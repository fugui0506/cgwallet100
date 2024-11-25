class MyTimer {
  static final MyTimer _instance = MyTimer._internal();
  factory MyTimer() => _instance;
  MyTimer._internal();

  static String getDuration(int seconds) => _instance._getDuration(seconds);
  static String now() => _instance._now();
  static Duration pass(int createAt) => _instance._pass(createAt);
  static bool isPassToday(int createAt) => _instance._isPassToday(createAt);

  String _getDuration(int seconds) {
    String s = '';
    String m = '';
    String h = '';

    if (seconds % 60 < 10) {
      s = '0${seconds % 60}';
    } else {
      s = '${seconds % 60}';
    }

    if (seconds ~/ 60 % 60 < 10) {
      m = '0${seconds ~/ 60 % 60}';
    } else {
      m = '${seconds ~/ 60 % 60}';
    }

    if (seconds ~/ 3600 < 10) {
      h = '0${seconds ~/ 3600}';
    } else {
      h = '${seconds ~/ 3600}';
    }
    return seconds ~/ 3600 > 0 ? '$h:$m:$s' : '$m:$s';
  }

  String _now() {
    DateTime now = DateTime.now();
    return now.toString().split('.').first;
  }

  Duration _pass(int createAt) {
    final nowTimeUTC = DateTime.now().toUtc();
    final createTimeUTC = DateTime.fromMillisecondsSinceEpoch(createAt).toUtc();
    return nowTimeUTC.difference(createTimeUTC);
  }

  bool _isPassToday(int createAt) {
    final nowTimeUTC = DateTime.now().toUtc().add(Duration(hours: 8));
    final createTimeUTC = DateTime.fromMillisecondsSinceEpoch(createAt).toUtc().add(Duration(hours: 8));
    return nowTimeUTC.day > createTimeUTC.day;
  }
}
