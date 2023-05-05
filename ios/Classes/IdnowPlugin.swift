import Flutter
import UIKit
import IDNowSDKCore

public class IdnowPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "idnow", binaryMessenger: registrar.messenger())
    let instance = IdnowPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if(call.method == "getPlatformVersion") {
          result("iOS " + UIDevice.current.systemVersion)
      } else if(call.method == "startIdentification") {
          if let args = call.arguments as? Dictionary<String, Any>,
              let code = args["code"] as? String {
              let controller = (UIApplication.shared.delegate?.window??.rootViewController)!;
              IDNowSDK.shared.start(token: code, preferredLanguage:"en", fromViewController: controller, listener:{(res: IDNowSDK.IdentResult.type, statusCode: IDNowSDK.IdentResult.statusCode, message: String) in
                      if res == .ERROR {
                          print("Error", statusCode.description);
                          result(statusCode.description);
                      } else if res == .CANCELLED {
                          print("CANCELLED");
                          result("CANCELLED");
                      } else if res == .FINISHED {
                          print("FINISHED");
                          result("CANCELLED");
                      }
                  })
            } else {
              result(FlutterError.init(code: "bad args", message: nil, details: nil))
            }
      }
  }
}
