//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <my_utils/my_utils_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) my_utils_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MyUtilsPlugin");
  my_utils_plugin_register_with_registrar(my_utils_registrar);
}
