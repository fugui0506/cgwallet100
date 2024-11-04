//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import device_info_plus
import my_device_info
import my_utils
import package_info_plus
import path_provider_foundation
import sqflite_darwin

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  MyDeviceInfoPlugin.register(with: registry.registrar(forPlugin: "MyDeviceInfoPlugin"))
  MyUtilsPlugin.register(with: registry.registrar(forPlugin: "MyUtilsPlugin"))
  FPPPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FPPPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
}
