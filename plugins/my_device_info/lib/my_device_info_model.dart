class MyDeviceInfoModel {
  String brand;
  String model;
  String version;
  String id;

  MyDeviceInfoModel({
    required this.model,
    required this.id,
    required this.brand,
    required this.version,
  });
  
  factory MyDeviceInfoModel.fromJson(Map<String, dynamic> json) => MyDeviceInfoModel(
    model: json["model"] ?? '',
    id: json["id"] ?? '',
    brand: json["brand"] ?? '',
    version: json["version"] ?? '',
  );

  factory MyDeviceInfoModel.empty() => MyDeviceInfoModel(
    model: '',
    id: '',
    brand: '',
    version: '',
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "id": id,
    "brand": brand,
    "device": version,
  };
}