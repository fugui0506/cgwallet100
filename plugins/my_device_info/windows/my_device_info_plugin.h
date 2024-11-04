#ifndef FLUTTER_PLUGIN_MY_DEVICE_INFO_PLUGIN_H_
#define FLUTTER_PLUGIN_MY_DEVICE_INFO_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace my_device_info {

class MyDeviceInfoPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MyDeviceInfoPlugin();

  virtual ~MyDeviceInfoPlugin();

  // Disallow copy and assign.
  MyDeviceInfoPlugin(const MyDeviceInfoPlugin&) = delete;
  MyDeviceInfoPlugin& operator=(const MyDeviceInfoPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace my_device_info

#endif  // FLUTTER_PLUGIN_MY_DEVICE_INFO_PLUGIN_H_
