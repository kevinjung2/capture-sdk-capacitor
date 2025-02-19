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
    @objc func setCallbacks(){
        print("setting callbacks")
        implementation.eventCallbacksManager.append { device in
            var returnValue = ["name": ""]
            returnValue["name"] = device.description
            
            print("plugin notifying listeners for device manager arrival")
            self.notifyListeners("DeviceManagerArrival", data: returnValue)
        }
        implementation.eventCallbacksManager.append { device in
            var returnValue = ["name": ""]
            returnValue["name"] = device.description

            print("plugin notifying listeners for device manager removal")
            self.notifyListeners("DeviceManagerRemoval", data: returnValue)
        }
        implementation.eventCallbacksDevice.append { device in
            var returnValue = ["name": ""]
            returnValue["name"] = device.deviceInfo.name!
//            print(device.deviceInfo.description)
//            print(device.deviceInfo.deviceType.rawValue)
//            print(device.deviceInfo.guid)
//            print(device.deviceInfo.handle.debugDescription)
//            print(device.deviceInfo.name)
            print("plugin notifying listeners for device arrival")
            self.notifyListeners("DeviceArrival", data: returnValue)
        }
        implementation.eventCallbacksDevice.append { device in
            let returnValue = ["name": device.deviceInfo.name!]
            
            print("plugin notifying listeners for device removal")
            self.notifyListeners("DeviceRemoval", data: returnValue)
        }
        implementation.eventCallbacksData.append { device, decodedData, string in
            var returnValue = ["name": "", "decodedData": "", "string": string]
            returnValue["name"] = device.deviceInfo.name
            returnValue["decodedData"] = decodedData.stringFromDecodedData()

            print("plugin notifying listeners for decoded data")
            self.notifyListeners("DecodedDataRecieved", data: returnValue)
        }
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
        
        // call.reject("initialization failed")
    }
    
    @objc func setFavorite(_ call: CAPPluginCall) {
        guard let favoriteString = call.options["favorite"] as? String else {
            call.reject("Must provide a favorite string")
            return
        }
        
        call.resolve(["result": implementation.setFavorite(favoriteString)])
    }
}

