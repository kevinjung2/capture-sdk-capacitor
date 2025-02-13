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
        CAPPluginMethod(name: "initCapture", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setFavorite", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = CaptureSDK()

    //TODO:: set all of these callbacks to the same listenertype, that also returns data to identify which
    // type of event is being emmitted, that way the client only needs to set up one event listener.
    func setCallbacks(){
        implementation.eventCallbacksManager.append { device in self.notifyListeners("DeviceManagerArrival", ["data": device]) }
        implementation.eventCallbacksManager.append { device in self.notifyListeners("DeviceManagerRemoval", ["data": device]) }
        implementation.eventCallbacksDevice.append { device in self.notifyListeners("DeviceArrival", ["data": device]) }
        implementation.eventCallbacksDevice.append { device in self.notifyListeners("DeviceRemoval", ["data": device]) }
    }

    @objc func initCapture(_ call: CAPPluginCall) {
        setCallbacks()
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
        //todo:: fix resolve reject to only reject when initSDK fails
        call.resolve(["result": implementation.initSDK(devId, appId, appKey)])

        call.reject("initialization failed")
    }

    @objc func setFavorite(_ call: CAPPluginCall) {
        guard let favoriteString = call.options["favorite"] as? String else {
            call.reject("Must provide a favorite string")
            return
        }

        call.resolve(["result": implentation.setFavorite(favoriteString)])
    }
}
