#include "include/my_widgets/my_widgets_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "my_widgets_plugin.h"

void MyWidgetsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  my_widgets::MyWidgetsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
