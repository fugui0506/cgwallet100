import Cocoa
import FlutterMacOS
import IOKit

public class MyDeviceInfoPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "my_device_info", binaryMessenger: registrar.messenger)
        let instance = MyDeviceInfoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getDeviceInfo":
            var deviceInfo = [String: Any]()
            deviceInfo["brand"] = "Apple"
            deviceInfo["model"] = getDeviceModel()
            deviceInfo["systemVersion"] = "macOS \(ProcessInfo.processInfo.operatingSystemVersion.majorVersion).\(ProcessInfo.processInfo.operatingSystemVersion.minorVersion).\(ProcessInfo.processInfo.operatingSystemVersion.patchVersion)"
            deviceInfo["id"] = getMacSerialNumber() ?? "Unknown"
            result(deviceInfo)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        guard let identifier = String(validatingUTF8: withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                $0
            }
        }) else {
            return "unknown"
        }

        let modelMap: [String: String] = [
            "x86_64": "Simulator",
            "arm64": "Simulator",
        ]

        return modelMap[identifier] ?? "Unknown"
    }

    private func getMacSerialNumber() -> String? {
        var masterPort: mach_port_t = 0
        let result = IOMasterPort(mach_port_t(MACH_PORT_NULL), &masterPort)

        if result != KERN_SUCCESS {
            return nil
        }

        let matchingDict = IOServiceMatching("IOPlatformExpertDevice")
        let service = IOServiceGetMatchingService(masterPort, matchingDict)

        guard service != 0 else {
            return nil
        }

        defer {
            IOObjectRelease(service)
        }

        let kIOPlatformSerialNumber: NSString = "IOPlatformSerialNumber"

        if let serialNumberAsCFString = IORegistryEntryCreateCFProperty(service, kIOPlatformSerialNumber, kCFAllocatorDefault, 0)?.takeRetainedValue() as? String {
            return serialNumberAsCFString
        }

        return nil
    }
}