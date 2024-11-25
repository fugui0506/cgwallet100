class MyVersion {
  static final MyVersion _instance = MyVersion._internal();
  factory MyVersion() => _instance;
  MyVersion._internal();

  static bool isUpdateVersion(String locale, String service) => _instance._isUpdateVersion(locale, service);

  bool _isUpdateVersion(String locale, String service) {
    final localData = _getVersionData(locale);
    final serviceData = _getVersionData(service);

    for (int i = 0; i < 3; i++) {
      int comparison = localData[i].compareTo(serviceData[i]);
      if (comparison < 0) {
        return true;
      } else if (comparison > 0) {
        return false;
      }
    }
    return false;
  }

  List<int> _getVersionData(String version) {
    List<String> strList = version.split('.').map((e) => e.replaceAll(RegExp(r'\D'), '')).toList();

    List<String> newStrList = List.filled(3, '0');
    for (int i = 0; i < strList.length && i < 3; i++) {
      newStrList[i] = strList[i].isEmpty ? '0' : strList[i];
    }

    return newStrList.map(int.parse).toList();
  }
}


