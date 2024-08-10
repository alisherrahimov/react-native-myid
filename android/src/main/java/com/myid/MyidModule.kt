package com.myid

import android.app.Activity
import android.content.Intent
import com.facebook.react.bridge.ActivityEventListener
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.LifecycleEventListener
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.WritableMap
import com.facebook.react.modules.core.DeviceEventManagerModule
import uz.myid.android.sdk.capture.MyIdClient
import uz.myid.android.sdk.capture.MyIdConfig
import uz.myid.android.sdk.capture.MyIdException
import uz.myid.android.sdk.capture.MyIdResult
import uz.myid.android.sdk.capture.MyIdResultListener
import uz.myid.android.sdk.capture.model.MyIdBuildMode

import java.util.Locale


class MyidModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext),
  MyIdResultListener, LifecycleEventListener, ActivityEventListener {
  private val myIdClient = MyIdClient()

  override fun getName(): String {
    return NAME
  }

  // Example method
  // See https://reactnative.dev/docs/native-modules-android


  companion object {
    const val NAME = "Myid"
  }

  override fun onSuccess(result: MyIdResult) {
    val params = Arguments.createMap()
    params.putString("code", result.code)
    params.putDouble("comparison", result.comparison)
    println(params)
    println("params")
    sendEvent("onSuccess", params)
  }

  override fun onError(exception: MyIdException) {
    val params = Arguments.createMap()
    params.putString("message", exception.message)
    params.putInt("code", exception.code)
    println(params)
    println("error")
    sendEvent("onError", params)
  }

  override fun onUserExited() {
    val params = Arguments.createMap()
    params.putString("message", "User Exited")

    sendEvent("onUserExited", params)
  }

  @ReactMethod
  fun addListener(eventName: String) {
    // Add custom code for adding a listener
  }

  @ReactMethod
  fun removeListeners(count: Int) {
    // Add custom code for removing listeners
  }

  @ReactMethod
  fun startMyId(
    clientId: String,
    clientHash: String,
    clientHashId: String,
    lang: String,
    type: String
  ) {
    val mode = when (type) {
      "DEBUG" -> MyIdBuildMode.DEBUG
      else -> MyIdBuildMode.PRODUCTION
    }
    val language = when (lang) {
      "EN" -> "en"
      "RU" -> "ru"
      "UZ" -> "uz"
      else -> "ky"
    }
    val config = MyIdConfig.Builder(clientId)
      .withClientHash(clientHash, clientHashId)
      .withLocale(Locale(language))
      .withBuildMode(mode)
      .build();
    if (currentActivity !== null) {
      myIdClient.startActivityForResult(
        currentActivity!!,
        1,
        config
      )
    }

  }


  override fun onHostResume() {
    TODO("Not yet implemented")
  }

  override fun onHostPause() {
    TODO("Not yet implemented")
  }

  override fun onHostDestroy() {
    TODO("Not yet implemented")
  }

  override fun onActivityResult(p0: Activity?, p1: Int, p2: Int, p3: Intent?) {
    myIdClient.handleActivityResult(p2, this);
  }

  override fun onNewIntent(p0: Intent?) {
    TODO("Not yet implemented")
  }

  private fun sendEvent(
    eventName: String,
    params: WritableMap
  ) {
    reactApplicationContext
      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
      .emit(eventName, params)
  }

}
