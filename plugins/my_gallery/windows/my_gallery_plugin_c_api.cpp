#include "include/my_gallery/my_gallery_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "my_gallery_plugin.h"

void MyGalleryPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  my_gallery::MyGalleryPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
