import 'package:flutter/services.dart';

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
    const platform = MethodChannel("Haptik_FlutterAPP");
    await platform.invokeMethod('botCustomLaunch', {
      'authCode': "YOUR_AUTH_CODE",
      'authId': "YOUR_AUTH_ID",
      'signupType': "third_party",
      'userName': "USER_NAME",
      'email': "ag@gm.com",
      'mobileNo': "1234567890",
      'launchMessage': launchMessage,
    });
  }

  androidGuestBot() async {
    const platform = MethodChannel("Haptik_FlutterAPP");
    await platform.invokeMethod('botGuestLaunch');
  }
}
