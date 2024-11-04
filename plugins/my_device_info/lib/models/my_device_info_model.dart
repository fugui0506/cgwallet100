class MyDeviceInfoModel {
  String brand;
  String model;
  String systemVersion;
  String id;

  String appName;
  String appVersion;

  MyDeviceInfoModel({
    required this.model,
    required this.id,
    required this.brand,
    required this.systemVersion,
    required this.appName,
    required this.appVersion,
  });
  
  factory MyDeviceInfoModel.fromJson(Map<String, dynamic> json) => MyDeviceInfoModel(
    model: json["model"] ?? '',
    id: json["id"] ?? '',
    brand: json["brand"] ?? '',
    systemVersion: json["systemVersion"] ?? '',
    appName: json["appName"] ?? '',
    appVersion: json["appVersion"] ?? '',
  );

  factory MyDeviceInfoModel.empty() => MyDeviceInfoModel(
    model: '',
    id: '',
    brand: '',
    systemVersion: '',
    appName: '',
    appVersion: '',
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "id": id,
    "brand": brand,
    "systemVersion": systemVersion,
    "appName": appName,
    "appVersion": appVersion,
  };
}