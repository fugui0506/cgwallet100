import 'package:my_flutter_basic/common/common.dart';

class CaptchaModel {
  CaptchaModel({
    required this.captchaId,
    required this.picPath,
    required this.captchaLength,
    required this.openCaptcha,
  });

  String captchaId;
  String picPath;
  int captchaLength;
  bool openCaptcha;

  Future<void> update() async {
    await UserController.to.myDio?.get<CaptchaModel>(ApiPath.base.captcha,
      onSuccess: (code, msg, results) async {
        captchaId = results.captchaId;
        picPath = results.picPath;
        captchaLength = results.captchaLength;
        openCaptcha = results.openCaptcha;
      },
      onModel: (m) => CaptchaModel.fromJson(m),
    );
  }

  factory CaptchaModel.fromJson(Map<String, dynamic> json) => CaptchaModel(
    captchaId: json["captchaId"] ?? '',
    picPath: json["picPath"] ?? '',
    captchaLength: json["captchaLength"] ?? -1,
    openCaptcha: json["openCaptcha"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "captchaId": captchaId,
    "picPath": picPath,
    "captchaLength": captchaLength,
    "openCaptcha": openCaptcha,
  };

  factory CaptchaModel.empty() => CaptchaModel(
    captchaId: '',
    picPath: '',
    captchaLength: -1,
    openCaptcha: false,
  );
}

class CaptchaKeyModel {
  CaptchaKeyModel({
    required this.captchaId,
    required this.type,
  });

  String captchaId;
  int type;

  Future<void> update() async {
    await UserController.to.myDio?.get<CaptchaKeyModel>(ApiPath.base.getCaptchaKey,
      onSuccess: (code, msg, results) async {
        captchaId = results.captchaId;
        type = results.type;
      },
      onModel: (m) => CaptchaKeyModel.fromJson(m),
    );
  }

  factory CaptchaKeyModel.fromJson(Map<String, dynamic> json) => CaptchaKeyModel(
    captchaId: json["captchaId"] ?? '',
    type: json["type"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "captchaId": captchaId,
    "type": type,
  };

  factory CaptchaKeyModel.empty() => CaptchaKeyModel(
    captchaId: '',
    type: 0,
  );
}
