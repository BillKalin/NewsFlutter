package com.hantech.studio.news_fluttter

import android.annotation.TargetApi
import android.app.Service
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.os.PowerManager

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    companion object {
        const val CHANNEL = "test_channel"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler(object : MethodChannel.MethodCallHandler {
            override fun onMethodCall(p0: MethodCall, p1: MethodChannel.Result) {
                if (p0.method == "getBatteryLevel") {
                    p1.success(getBatteryLevel())
                }
            }

        })
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getBatteryLevel(): Int {
        val bm = getSystemService(Service.BATTERY_SERVICE) as BatteryManager
        return bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
