//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <my_deep_link/my_deep_link_plugin.h>
#include <my_device_info/my_device_info_plugin.h>
#include <my_utils/my_utils_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) my_deep_link_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MyDeepLinkPlugin");
  my_deep_link_plugin_register_with_registrar(my_deep_link_registrar);
  g_autoptr(FlPluginRegistrar) my_device_info_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MyDeviceInfoPlugin");
  my_device_info_plugin_register_with_registrar(my_device_info_registrar);
  g_autoptr(FlPluginRegistrar) my_utils_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MyUtilsPlugin");
  my_utils_plugin_register_with_registrar(my_utils_registrar);
}
