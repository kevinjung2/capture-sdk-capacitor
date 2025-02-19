import Foundation
import CaptureSDK

@objc public class CaptureSDK: 
    NSObject, 
    SKTCaptureHelperDelegate,
    CaptureHelperDeviceManagerPresenceDelegate,
    CaptureHelperDevicePresenceDelegate,
    CaptureHelperDeviceDecodedDataDelegate,
    CaptureHelperErrorDelegate {

    var captureHelper = CaptureHelper.sharedInstance
    var deviceManager: CaptureHelperDeviceManager?
    // here we store all of the callback functions so that we can send the events to the plugin
    // first we store the DeviceManager Callbacks
    // order of events are:
    //  0. deviceManagerArrival
    //  1. deviceManagerRemoval
    public var eventCallbacksManager: [(CaptureHelperDeviceManager)->()] = []
    // then down here we store the Device Callbacks
    //  0. deviceArrival
    //  1. deviceRemoval
    public var eventCallbacksDevice: [(CaptureHelperDevice)->()] = []
    // then down here we store the callbacks for when the app recieves data
    //  o. decodedDataReceived
    public var eventCallbacksData: [(CaptureHelperDevice, SKTCaptureDecodedData, String)->()] = []

    @objc public func initSDK(_ devId: String, _ appId: String, _ appKey: String) -> String {
        captureHelper.dispatchQueue = DispatchQueue.main
        captureHelper.pushDelegate(self)
        let appInfo = SKTAppInfo();
        appInfo.developerID = devId
        appInfo.appID = appId
        appInfo.appKey = appKey
        captureHelper.openWithAppInfo(appInfo, withCompletionHandler: { (result) in
            print("Result of Capture initialization: \(result.rawValue)")
            })
        return "success"
    }

    func setFavorite(_ favorite: String) -> String {
        guard let manager = deviceManager else {
            print("No device manager present")
            return "failed"
        }
        manager.setFavoriteDevices(favorite, withCompletionHandler: { (result) in
            print("setting new favorites returned \(result.rawValue)")
            if(result == SKTCaptureErrors.E_NOERROR){
                print("no errors from set Favorites")
            }
        })
        return "success"
    }

    public func didNotifyArrivalForDeviceManager(_ device: CaptureHelperDeviceManager, withResult result: SKTResult) {
        print("Device manager arrival \(result.rawValue)")
        deviceManager = device
        eventCallbacksManager[0](device)
    }

    public func didNotifyRemovalForDeviceManager(_ device: CaptureHelperDeviceManager, withResult result: SKTResult) {
        print("Device manager removal")
        deviceManager = nil
        eventCallbacksManager[1](device)
    }

    public func didNotifyArrivalForDevice(_ device: CaptureHelperDevice, withResult result: SKTResult) {
        print("Main view device arrival:\(String(describing: device.deviceInfo.name))")
        eventCallbacksDevice[0](device)
    }

    public func didNotifyRemovalForDevice(_ device: CaptureHelperDevice, withResult result: SKTResult) {
        print("Main view device removal:\(device.deviceInfo.name!)")
        eventCallbacksDevice[1](device)
    }

    public func didReceiveDecodedData(_ decodedData: SKTCaptureDecodedData?, fromDevice device: CaptureHelperDevice, withResult result: SKTResult) {
        if result == SKTCaptureErrors.E_NOERROR {
            guard let unwrappedData = decodedData else {
                print("no data")
                return
            }
            //let rawData = unwrappedData.decodedData
            let string = unwrappedData.stringFromDecodedData()!
            print("data: \(String(describing: decodedData?.decodedData))")
            print("Decoded Data \(String(describing: string))")

            eventCallbacksData[0](device, unwrappedData, string)
        } else {
            print(result.rawValue)
        }
    }
    
    public func didReceiveError(_ error: SKTResult) {
        print("Receive a Capture error: \(error)")
    }
}
