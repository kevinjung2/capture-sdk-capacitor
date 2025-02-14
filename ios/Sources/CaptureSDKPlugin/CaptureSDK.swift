import Foundation
import CaptureSDK

@objc public class CaptureSDK: 
    NSObject, 
    CaptureHelperDelegate, 
    CaptureHelperDevicePresenceDelegate {

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

    func setFavorite(_ favorite: String) {
        guard let manager = deviceManager else {
            print("No device manager present")
            return
        }
        manager.setFavoriteDevices(favorite, withCompletionHandler: { (result) in
                print("setting new favorites returned \(result.rawValue)")
                })
    }

    public func didNotifyArrivalForDeviceManager(_ device: CaptureHelperDeviceManager, withResult result: SKTResult) {
        print("Device manager arrival")
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

}
