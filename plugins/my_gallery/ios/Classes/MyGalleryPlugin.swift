import Flutter
import UIKit
import Photos

public class MyGalleryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_gallery", binaryMessenger: registrar.messenger())
    let instance = MyGalleryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "saveImage":
        guard let args = call.arguments as? [String: Any],
              let path = args["path"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "图片路径不能为空", details: nil))
            return
        }
        saveImageToGallery(path: path, result: result)
    case "decodeQRCode":
        guard let args = call.arguments as? [String: Any],
              let path = args["path"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "图片路径不能为空", details: nil))
            return
        }
        decodeQRCode(from: path, result: result)
    default:
        result(FlutterMethodNotImplemented)
    }
  }

  private func saveImageToGallery(path: String, result: @escaping FlutterResult) {
      guard let url = URL(string: path) else {
          result(FlutterError(code: "INVALID_PATH", message: "图片路径无效", details: nil))
          return
      }

      PHPhotoLibrary.shared().performChanges({
          PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
      }) { success, error in
          if success {
              result(true)
          } else {
              let errorMessage = error?.localizedDescription ?? "未知错误"
              result(FlutterError(code: "SAVE_FAILED", message: "保存图片失败: \(errorMessage)", details: nil))
          }
      }
  }

  private func decodeQRCode(from path: String, result: @escaping FlutterResult) {
      guard let image = UIImage(contentsOfFile: path) else {
          result(FlutterError(code: "INVALID_IMAGE", message: "无法加载图片", details: nil))
          return
      }

      let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
      let ciImage = CIImage(image: image)
      let features = detector?.features(in: ciImage!) as? [CIQRCodeFeature]
      let qrCodeMessages = features?.compactMap { $0.messageString }

      if let message = qrCodeMessages?.first {
          result(message)
      } else {
          result(FlutterError(code: "QR_NOT_FOUND", message: "未找到二维码", details: nil))
      }
  }
}