package com.example.my_device_info

import android.app.Activity
import android.content.Intent
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.os.Process

class MyDeviceInfoPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private lateinit var context: android.content.Context
  private var activity: Activity? = null

  // FlutterPlugin 方法
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my_device_info")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  // MethodCallHandler 方法
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

      result.success(build)
    } else if (call.method == "restart") {
      restartApp()
      result.success("App restarted successfully")
    } else {
      result.notImplemented()
    }
  }

  // 重启应用
  private fun restartApp() {
    activity?.let { currentActivity ->
      val intent = currentActivity.packageManager.getLaunchIntentForPackage(currentActivity.packageName)
      intent?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK)
      currentActivity.startActivity(intent)
      currentActivity.finishAffinity()

      // 杀掉当前进程
      Process.killProcess(Process.myPid())
      System.exit(0)
    }
  }

  // ActivityAware 方法
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}