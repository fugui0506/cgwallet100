class WebViewArgumentsModel {
  WebViewArgumentsModel({
    this.title = '',
    this.url = '',

  });

  String title;
  String url;

  factory WebViewArgumentsModel.fromJson(Map<String, dynamic> json) => WebViewArgumentsModel(
    title: json["title"] ?? '',
    url: json["url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
  };
}

class UrlLatency {
  String url;
  Duration latency;

  UrlLatency(this.url, this.latency);
}

class CustomerChatViewArgumentsModel {
  CustomerChatViewArgumentsModel({
    required this.cert,
    this.sysOrderId,
    required this.apiUrl,
    required this.imageUrl,
    this.userId,
    this.avatarUrl,
    required this.sign,
    required this.tenantId
  });

  String apiUrl;
  String imageUrl;
  String cert;
  String? sysOrderId;
  int? userId;
  String? avatarUrl;
  String sign;
  int tenantId;

  factory CustomerChatViewArgumentsModel.fromJson(Map<String, dynamic> json) => CustomerChatViewArgumentsModel(
    cert: json["cert"],
    sysOrderId: json["sysOrderId"],
    apiUrl: json["apiUrl"],
    imageUrl: json["imageUrl"],
    userId: json["userId"],
    avatarUrl: json["avatarUrl"],
    sign: json["sign"],
    tenantId: json["tenantId"]
  );

  Map<String, dynamic> toJson() => {
    "cert": cert,
    "sysOrderId": sysOrderId,
    "apiUrl": apiUrl,
    "imageUrl": imageUrl,
    "userId": userId,
    "avatarUrl": avatarUrl,
    "sign": sign,
    "tenantId": tenantId
  };
}
