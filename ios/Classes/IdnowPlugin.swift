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
              IDNowSDK.shared.start(token: code, preferredLanguage:"en", fromViewController: controller, listener:{(result: IDNowSDK.IdentResult.type, statusCode: IDNowSDK.IdentResult.statusCode, message: String) in
                      if result == .ERROR {
        //                  print(statusCode.description)
                          self.showAlert(text: statusCode.description)
                      } else if result == .FINISHED {

                      }
                  })
              result("iOS " + UIDevice.current.systemVersion)
            } else {
              result(FlutterError.init(code: "bad args", message: nil, details: nil))
            }
      }
  }

    func showAlert(text: String){
        let controller = (UIApplication.shared.delegate?.window??.rootViewController)!;
        let alert = UIAlertController(title: nil, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
