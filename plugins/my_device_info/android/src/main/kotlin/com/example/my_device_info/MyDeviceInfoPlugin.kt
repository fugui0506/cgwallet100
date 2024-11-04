package com.example.my_device_info

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.os.Build
import android.provider.Settings

/** MyDeviceInfoPlugin */
class MyDeviceInfoPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: android.content.Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my_device_info")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getDeviceInfo") {
      val contentResolver = context.contentResolver
      val build: MutableMap<String, Any> = HashMap()

      // 手机品牌（xiaomi)
      build["brand"] = Build.BRAND

      // 手机型号 (Mi 6X)
      build["model"] = Build.MODEL

      // 系统版本（Android 9 28)
      build["systemVersion"] = "Android ${Build.VERSION.RELEASE} ${Build.VERSION.SDK_INT}"

      // 设备ID (识别码)
      build["id"] = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID) ?: "Unknown"

      //build["board"] = Build.BOARD
      //build["bootloader"] = Build.BOOTLOADER
      //build["device"] = Build.DEVICE
      //build["display"] = Build.DISPLAY
      //build["fingerprint"] = Build.FINGERPRINT
      //build["hardware"] = Build.HARDWARE
      //build["host"] = Build.HOST
      //build["manufacturer"] = Build.MANUFACTURER
      //build["product"] = Build.PRODUCT
      //build["tags"] = Build.TAGS
      //build["type"] = Build.TYPE

      result.success(build)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
