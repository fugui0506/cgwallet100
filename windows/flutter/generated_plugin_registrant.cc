//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <my_device_info/my_device_info_plugin_c_api.h>
#include <my_utils/my_utils_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  MyDeviceInfoPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MyDeviceInfoPluginCApi"));
  MyUtilsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MyUtilsPluginCApi"));
}
