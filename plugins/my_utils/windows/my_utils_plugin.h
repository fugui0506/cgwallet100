#ifndef FLUTTER_PLUGIN_MY_UTILS_PLUGIN_H_
#define FLUTTER_PLUGIN_MY_UTILS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace my_utils {

class MyUtilsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MyUtilsPlugin();

  virtual ~MyUtilsPlugin();

  // Disallow copy and assign.
  MyUtilsPlugin(const MyUtilsPlugin&) = delete;
  MyUtilsPlugin& operator=(const MyUtilsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace my_utils

#endif  // FLUTTER_PLUGIN_MY_UTILS_PLUGIN_H_
