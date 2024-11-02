#include "include/my_utils/my_utils_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "my_utils_plugin.h"

void MyUtilsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  my_utils::MyUtilsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
