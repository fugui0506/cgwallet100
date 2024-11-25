#ifndef FLUTTER_PLUGIN_MY_WIDGETS_PLUGIN_H_
#define FLUTTER_PLUGIN_MY_WIDGETS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace my_widgets {

class MyWidgetsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MyWidgetsPlugin();

  virtual ~MyWidgetsPlugin();

  // Disallow copy and assign.
  MyWidgetsPlugin(const MyWidgetsPlugin&) = delete;
  MyWidgetsPlugin& operator=(const MyWidgetsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace my_widgets

#endif  // FLUTTER_PLUGIN_MY_WIDGETS_PLUGIN_H_
