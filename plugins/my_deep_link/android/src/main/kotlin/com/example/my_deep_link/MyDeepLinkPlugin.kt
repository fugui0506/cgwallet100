package com.example.my_deep_link

import android.content.Intent
import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MyDeepLinkPlugin */
class MyDeepLinkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel: MethodChannel
  private var activity: FlutterActivity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my_deep_link")
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity as? FlutterActivity
    handleIntent(activity?.intent)

    binding.addOnNewIntentListener { newIntent ->
      handleIntent(newIntent)
      true
    }
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity as? FlutterActivity
    handleIntent(activity?.intent)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  private fun handleIntent(intent: Intent?) {
    if (intent != null) {
      val action = intent.action
      val data = intent.dataString
      if (Intent.ACTION_VIEW == action && data != null) {
        channel.invokeMethod("sendDeepLink", data)
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}