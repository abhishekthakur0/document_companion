package dev.abhishekthakur.document_companion

import io.flutter.embedding.android.FlutterActivity
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.opencv.android.OpenCVLoader
import io.flutter.embedding.engine.FlutterEngine


class MainActivity: FlutterActivity() {
    private val CHANNEL = "dev.abhishekthakur/document_companion";
    private lateinit var channel: MethodChannel
    private var OpenCVFLag = false


    companion object {
        const val TAG = "dev.abhishekthakur.Log.Tag"
        const val PLUGIN_ID = "dev.abhishekthakur/document_companion"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->

            if (!OpenCVFLag) {
                if (!OpenCVLoader.initDebug()) {
                    Log.i(TAG, "Unable to load OpenCV")
                } else {
                    OpenCVFLag = true
                    Log.i(TAG, "OpenCV loaded Successfully")
                }
            }

            when (call.method) {
                "findContourPhoto" -> {
                    try {
                        OpenCVPlugin.findContourPhoto(
                            result,
                            call.argument<ByteArray>("byteData") as ByteArray,
                            call.argument<ByteArray>("minContourArea") as Double
                        )
                    } catch (e: Exception) {
                        result.error("FlutterDocumentScanner-Error", "Android: " + e.message, e)
                    }
                }

                "adjustingPerspective" -> {
                    try {
                        OpenCVPlugin.adjustingPerspective(
                            call.argument<ByteArray>("byteData") as ByteArray,
                            call.argument<List<Map<String, Any>>>("points") as List<Map<String, Any>>,
                            result
                        )
                    } catch (e: Exception) {
                        result.error("FlutterDocumentScanner-Error", "Android: " + e.message, e)
                    }
                }

                "applyFilter" -> {
                    try {
                        OpenCVPlugin.applyFilter(
                            result,
                            call.argument<ByteArray>("byteData") as ByteArray,
                            call.argument<List<Map<String, Any>>>("filter") as String
                        )
                    } catch (e: Exception) {
                        result.error("FlutterDocumentScanner-Error", "Android: " + e.message, e)
                    }
                }


                else -> result.notImplemented()
            }

        }
    }
}
