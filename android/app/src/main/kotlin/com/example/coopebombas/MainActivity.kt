package com.example.coopebombas;
import android.app.AlertDialog
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result


class MainActivity: FlutterActivity(), MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        channel = MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, "samples.flutter.dev/dialog")
        channel.setMethodCallHandler(this)
    }

     override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "showDialog") {
            val title = call.argument<String>("title")
            val message = call.argument<String>("message")
            val positiveButton = call.argument<String>("positiveButton")
            val negativeButton = call.argument<String>("negativeButton")

            if (title != null && message != null && positiveButton != null && negativeButton != null) {
                AlertDialog.Builder(this)
                    .setTitle(title)
                    .setMessage(message)
                    .setPositiveButton(positiveButton) { dialog, which ->
                        result.success(true)
                    }
                    .setNegativeButton(negativeButton) { dialog, which ->
                        result.success(false)
                    }
                    .setCancelable(false)
                    .show()
            } else {
                result.error("INVALID_ARGUMENTS", "Invalid arguments", null)
            }
        } else {
            result.notImplemented()
        }
    }
}