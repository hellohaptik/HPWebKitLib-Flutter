package com.example.haptik_flutter_example

import ai.haptik.android.wrapper.sdk.HaptikSDK
import ai.haptik.android.wrapper.sdk.model.InitData
import ai.haptik.android.wrapper.sdk.model.SignupData
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.util.Dictionary

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        val initData = InitData().apply {
            primaryColor = "#420420"
            composerPlaceholder = "Type message...."
            noHeader = true
            initializeLanguage = "en"
        }
        HaptikSDK.init(applicationContext)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "Haptik_FlutterAPP").setMethodCallHandler {
                call, result ->
            when (call.method) {
                "botCustomLaunch" -> {
                    var args = call.arguments
                    handleCustomBotLaunch(args as HashMap<String, String>)
                }
                "botGuestLaunch" -> {
                    handleGuestBotLaunch()
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun handleCustomBotLaunch (args: HashMap<String, String>) {
        val signUpData = SignupData().apply {
            authCode = args["authCode"] ?: "NA"
            authId = args["authId"] ?: "NA"
            signupType = args["signupType"] ?: "NA"
            email = args["email"] ?: "NA"
            mobileNo = args["mobileNo"] ?: "NA"
            userName = args["userName"] ?: "NA"
            customData = JSONObject().apply {
                put("custom-data-one", "date-one")
                put("custom-data-two", "data-two")
            }
        }
        args["launchMessage"]?.let { HaptikSDK.setLaunchMessage(it, hidden = true, skipMessage = true) }
        HaptikSDK.loadConversation(signUpData)

        HaptikSDK.logout(applicationContext)
    }

    private fun handleGuestBotLaunch() {
        HaptikSDK.loadGuestConversation()
    }
}
