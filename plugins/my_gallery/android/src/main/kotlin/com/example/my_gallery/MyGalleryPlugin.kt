package com.example.my_gallery

import android.content.ContentValues
import android.content.Context
import android.os.Build
import android.provider.MediaStore
import android.graphics.BitmapFactory
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.barcode.BarcodeScanning
import java.io.File
import java.io.FileInputStream
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class MyGalleryPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my_gallery")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "saveImage" -> {
        val path = call.argument<String>("path") ?: run {
          result.error("INVALID_ARGUMENT", "图片路径不能为空", null)
          return
        }
        saveImageToGallery(path, result)
      }
      "decodeQRCode" -> {
        val path = call.argument<String>("path") ?: run {
          result.error("INVALID_ARGUMENT", "图片路径不能为空", null)
          return
        }
        decodeQRCode(path, result)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun saveImageToGallery(path: String, result: MethodChannel.Result) {
    try {
      if (!::context.isInitialized) {
        result.error("UNINITIALIZED_CONTEXT", "上下文未初始化", null)
        return
      }

      val file = File(path)
      if (!file.exists() || !(file.extension.equals("png", true) || file.extension.equals("jpg", true))) {
        result.error("INVALID_FILE", "无效的文件类型或文件不存在", null)
        return
      }

      val values = ContentValues().apply {
        put(MediaStore.Images.Media.DISPLAY_NAME, file.name)
        put(MediaStore.Images.Media.MIME_TYPE, "image/png")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
          put(MediaStore.Images.Media.RELATIVE_PATH, "Pictures/Wallet")
          put(MediaStore.Images.Media.IS_PENDING, 1)
        }
      }

      context.contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)?.let { uri ->
        context.contentResolver.openOutputStream(uri)?.use { outputStream ->
          FileInputStream(file).use { inputStream -> inputStream.copyTo(outputStream) }
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            values.clear()
            values.put(MediaStore.Images.Media.IS_PENDING, 0)
            context.contentResolver.update(uri, values, null, null)
          }
          result.success(true)
        } ?: run {
          result.error("SAVE_FAILED", "打开输出流保存图片失败", null)
        }
      } ?: run {
        result.error("INSERT_FAILED", "插入图片到媒体库失败", null)
      }
    } catch (e: Exception) {
      result.error("EXCEPTION", "保存图片时发生错误: ${e.message}", null)
    }
  }

  private fun decodeQRCode(path: String, result: MethodChannel.Result) {
    try {
      val file = File(path)
      if (!file.exists()) {
        result.error("FILE_NOT_FOUND", "文件不存在", null)
        return
      }

      val bitmap = BitmapFactory.decodeFile(file.absolutePath) ?: run {
        result.error("INVALID_IMAGE", "无法解码图片", null)
        return
      }

      val image = InputImage.fromBitmap(bitmap, 0)
      BarcodeScanning.getClient().process(image)
        .addOnSuccessListener { barcodes ->
          if (barcodes.isNotEmpty()) {
            result.success(barcodes.first().rawValue)
          } else {
            result.success(null)
          }
        }
        .addOnFailureListener { e ->
          result.error("QR_SCAN_FAILED", "二维码扫描失败: ${e.message}", null)
        }
    } catch (e: Exception) {
      result.error("EXCEPTION", "解码二维码时发生错误: ${e.message}", null)
    }
  }
}