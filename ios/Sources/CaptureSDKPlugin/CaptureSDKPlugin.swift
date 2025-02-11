import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CaptureSDKPlugin)
public class CaptureSDKPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CaptureSDKPlugin"
    public let jsName = "CaptureSDK"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "initCapture", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = CaptureSDK()

    @objc func initCapture(_ call: CAPPluginCall) {
        guard let devId = call.options["devId"] as? String else {
            call.reject("Must provide dev id")
            return
        }
        guard let appId = call.options["appId"] as? String else {
            call.reject("Must provide app id")
            return
        }
        guard let appKey = call.options["appKey"] as? String else {
            call.reject("Must provide app key")
            return
        }

        call.resolve(["result": implementation.initSDK(devId, appId, appKey)])

        call.reject("initialization failed")
    }
}
