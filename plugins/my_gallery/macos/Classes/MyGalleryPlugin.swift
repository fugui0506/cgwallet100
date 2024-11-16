import Cocoa
import FlutterMacOS
import CoreImage

public class MyGalleryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_gallery", binaryMessenger: registrar.messenger)
    let instance = MyGalleryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "saveImage":
        guard let args = call.arguments as? [String: Any],
              let path = args["path"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "图片路径参数无效", details: nil))
            return
        }
        saveImageToGallery(path: path, result: result)
    case "decodeQRCode":
        guard let args = call.arguments as? [String: Any],
              let path = args["path"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "二维码图片路径参数无效", details: nil))
            return
        }
        decodeQRCode(from: path, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func saveImageToGallery(path: String, result: @escaping FlutterResult) {
    let fileManager = FileManager.default
    let destinationURL = fileManager.homeDirectoryForCurrentUser.appendingPathComponent("Pictures").appendingPathComponent(URL(fileURLWithPath: path).lastPathComponent)

    do {
        if fileManager.fileExists(atPath: destinationURL.path) {
            try fileManager.removeItem(at: destinationURL)
        }
        try fileManager.copyItem(at: URL(fileURLWithPath: path), to: destinationURL)
        result(true)
    } catch {
        result(FlutterError(code: "SAVE_FAILED", message: "保存图片到相册失败: \(error.localizedDescription)", details: nil))
    }
  }

  private func decodeQRCode(from path: String, result: @escaping FlutterResult) {
    guard let image = NSImage(contentsOfFile: path) else {
        result(FlutterError(code: "INVALID_IMAGE", message: "无法加载图片文件", details: nil))
        return
    }

    guard let ciImage = CIImage(data: image.tiffRepresentation!) else {
        result(FlutterError(code: "IMAGE_PROCESSING_FAILED", message: "图片处理失败，无法转换为CIImage", details: nil))
        return
    }

    let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
    let features = detector?.features(in: ciImage) as? [CIQRCodeFeature]
    let qrCodeMessages = features?.compactMap { $0.messageString }

    if let message = qrCodeMessages?.first {
        result(message)
    } else {
        result(FlutterError(code: "NO_QR_CODE", message: "未能在图片中找到二维码", details: nil))
    }
  }
}