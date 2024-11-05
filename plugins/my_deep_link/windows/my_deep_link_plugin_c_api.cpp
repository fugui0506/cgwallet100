#include "include/my_deep_link/my_deep_link_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "my_deep_link_plugin.h"

void MyDeepLinkPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  my_deep_link::MyDeepLinkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
