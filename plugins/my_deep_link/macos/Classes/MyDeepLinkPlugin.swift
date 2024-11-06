import Cocoa
import FlutterMacOS

public class MyDeepLinkPlugin: NSObject, FlutterPlugin, NSApplicationDelegate {
    private var channel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = MyDeepLinkPlugin()

        instance.channel = FlutterMethodChannel(name: "my_deep_link", binaryMessenger: registrar.messenger)
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
        registrar.addApplicationDelegate(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func application(_ sender: NSApplication, open urls: [URL]) {
        for url in urls {
            handleIncomingURL(url)
        }
    }

    private func handleIncomingURL(_ url: URL) {
        let deepLink = url.absoluteString

        DispatchQueue.main.async { [weak self] in
            self?.channel?.invokeMethod("sendDeepLink", arguments: deepLink)
        }
    }
}