import 'package:flutter/services.dart';
import 'package:haptik_sdk/InitData.dart';
import 'package:haptik_sdk/SignupData.dart';
import 'package:haptik_sdk/haptik_sdk.dart';

class BotLaunch {
  iosCustomBot(String launchMessage) async {
    const platform = MethodChannel('Haptik_FlutterAPP');
    await platform.invokeMethod('botCustomLaunch', {
      'setAuthCode': "YOUR_AUTH_CODE",
      'setAuthId': "YOUR_AUTH_ID",
      'setSignupType': "SIGNUP_TYPE",
      'userName': "USER_NAME",
      'email': "EMAIL",
      'mobile': "MOBILE_NO",
      'launchMessage': launchMessage,
    });
  }

  iosGuestBot() async {
    const platform = MethodChannel('Haptik_FlutterAPP');
    await platform.invokeMethod('botGuestLaunch');
  }

  androidCustomBot(String launchMessage) async {
    final haptikSdkPlugin = HaptikSdk();
    final signup = SignupData();
    signup.setAuthCode = "YOUR_AUTH_CODE";
    signup.setAuthId = "YOUR_AUTH_ID";
    signup.setSignupType = "SIGNUP_TYPE";
    signup.setCustomData = {
      'userName': "USER_NAME",
      'email': "EMAIL",
      'mobile': "MOBILE_NO",
    };

    if (launchMessage.trim() != "") {
      await haptikSdkPlugin.setLaunchMessage(launchMessage, true, true);
    }
    await haptikSdkPlugin.launchCustomSignupConversation(signup).then((value) {
      haptikSdkPlugin.logout();
    });
  }

  androidGuestBot() async {
    final haptikSdkPlugin = HaptikSdk();
    final initData = InitData();

    await haptikSdkPlugin.launchGuestConversation(initData).then((value) {
      haptikSdkPlugin.logout();
    });
  }
}
