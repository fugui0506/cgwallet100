import Flutter
import UIKit

public class MyDeviceInfoPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "my_device_info", binaryMessenger: registrar.messenger())
        let instance = MyDeviceInfoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getDeviceInfo" {
            var deviceInfo = [String: Any]()

            // 手机品牌（Apple)
            deviceInfo["brand"] = "Apple"

            // 获取具体的 iPhone 型号 (例如，iPhone 15)
            deviceInfo["model"] = getDeviceModel()

            // 系统版本 (iOS 14 18)
            deviceInfo["systemVersion"] = "IOS \(UIDevice.current.systemVersion)"

            // 设备ID (识别码)
            if let identifierForVendor = UIDevice.current.identifierForVendor?.uuidString {
                deviceInfo["id"] = identifierForVendor
                deviceInfo["id"] = identifierForVendor
            } else {
                deviceInfo["id"] = "Unknown"
            }

            result(deviceInfo)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        // 获取设备标识符
        guard let identifier = String(validatingUTF8: withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                $0
            }
        }) else {
            return "unknown"
        }

        let modelMap: [String: String] = [
            "arm64" : "Simulator",
            "x86_64" : "Simulator",
            "i386" : "Simulator",

            "iPhone1,1": "iPhone",
            "iPhone1,2": "iPhone 3G",
            "iPhone2,1": "iPhone 3GS",
            "iPhone3,1": "iPhone 4",
            "iPhone3,2": "iPhone 4",
            "iPhone3,3": "iPhone 4",
            "iPhone4,1": "iPhone 4S",
            "iPhone5,1": "iPhone 5",
            "iPhone5,2": "iPhone 5",
            "iPhone5,3": "iPhone 5c",
            "iPhone5,4": "iPhone 5c",
            "iPhone6,1": "iPhone 5s",
            "iPhone6,2": "iPhone 5s",
            "iPhone7,2": "iPhone 6",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone8,1": "iPhone 6s",
            "iPhone8,2": "iPhone 6s Plus",
            "iPhone8,4": "iPhone SE (1st generation)",
            "iPhone9,1": "iPhone 7",
            "iPhone9,3": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus",
            "iPhone9,4": "iPhone 7 Plus",
            "iPhone10,1": "iPhone 8",
            "iPhone10,4": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus",
            "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X",
            "iPhone10,6": "iPhone X",
            "iPhone11,8": "iPhone XR",
            "iPhone11,2": "iPhone XS",
            "iPhone11,4": "iPhone XS Max",
            "iPhone11,6": "iPhone XS Max",
            "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro",
            "iPhone12,5": "iPhone 11 Pro Max",
            "iPhone12,8": "iPhone SE (2nd generation)",
            "iPhone13,1": "iPhone 12 mini",
            "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro",
            "iPhone13,4": "iPhone 12 Pro Max",
            "iPhone14,4": "iPhone 13 mini",
            "iPhone14,5": "iPhone 13",
            "iPhone14,2": "iPhone 13 Pro",
            "iPhone14,3": "iPhone 13 Pro Max",
            "iPhone14,6": "iPhone SE (3rd generation)",
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone14,7": "iPhone 14",
            "iPhone14,8": "iPhone 14 Plus",
            "iPhone15,4": "iPhone 15",
            "iPhone15,5": "iPhone 15 Plus",
            "iPhone16,1": "iPhone 15 Pro",
            "iPhone16,2": "iPhone 15 Pro Max",
        ]

        // 获取设备型号
        if let model = modelMap[identifier] {
            // 处理模拟器的情况
            if model == "Simulator", let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"],

            let simModel = modelMap[simModelCode] {
                return simModel
            }
            return model
        }
        return "iPhone"
    }
}
