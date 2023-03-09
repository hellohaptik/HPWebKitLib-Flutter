import UIKit
import Flutter
import HPWebKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    HPKit.sharedSDK.setup()
    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
    let botChannel = FlutterMethodChannel(
      name: "Haptik_FlutterAPP", 
      binaryMessenger: flutterViewController.binaryMessenger
    )
    let navigationController = UINavigationController(rootViewController: flutterViewController)    
      
    navigationController.isNavigationBarHidden = true
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    botChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in

      switch call.method {
        case "botCustomLaunch":
          let args = call.arguments as? Dictionary<String, String>                    
          handleCustomBotLaunch(
            args: call.arguments as? Dictionary<String, String> ?? ["NA":"NA"],
            navigationController: navigationController
          )
          break

        case "botGuestLaunch":                  
          handleGuestBotLaunch(navigationController: navigationController)
          break

        case "botClose":
          navigationController.popViewController(animated: true)
          break

        default:
          result(FlutterMethodNotImplemented)
          break
      }
    })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

private func handleGuestBotLaunch(navigationController: UINavigationController) {
  do {
    try HPKit.sharedSDK.loadGuestConversation(
      launchController: navigationController.topViewController!, 
      customData: nil
    )
  } catch {
    print("Haptik Error : \(error)")
  }
}

private func handleCustomBotLaunch(args: [String : String], navigationController: UINavigationController) {

    let authAttribute = HPAttributesBuilder.build { (builder) in
        builder.authID = args["setAuthId"] ?? "NA"
        builder.authCode = args["setAuthCode"] ?? "NA"
        builder.userName = args["userName"] ?? "NA"
        builder.email = args["email"] ?? "NA"
        builder.mobile = args["mobile"] ?? "NA"
        builder.signupType = args["setSignupType"] ?? "NA"
    }

    do {
      let launchMessage = args["launchMessage"] ?? ""
      if (launchMessage.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
        HPKit.sharedSDK.setLaunchMessage(message: launchMessage, hidden: true)
      }
      
      try HPKit.sharedSDK.loadConversation(
        launchController: navigationController.topViewController!, 
        attributes: authAttribute, 
        customData: nil
      )
      HPKit.sharedSDK.logout()
    } catch {
      print("Haptik Error : \(error)")
    }
}

private func getCustomData () -> [String : String] {
  let customParams = ["Data1": "Value1", "Data2": "Value2", "Data3": "Value3"]
  return customParams
}
