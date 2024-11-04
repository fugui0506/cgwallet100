#include "include/my_device_info/my_device_info_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "my_device_info_plugin.h"

void MyDeviceInfoPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  my_device_info::MyDeviceInfoPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
