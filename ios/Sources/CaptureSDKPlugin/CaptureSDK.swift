import Foundation
import CaptureSDK

@objc public class CaptureSDK: NSObject, CaptureHelperDelegate {
    @objc public func initSDK(_ devId: String, _ appId: String, _ appKey: String) -> String {
        CaptureHelper.sharedInstance.dispatchQueue = DispatchQueue.main
        CaptureHelper.sharedInstance.pushDelegate(self)
        let appInfo = SKTAppInfo();
        appInfo.developerID = devId
        appInfo.appID = appId
        appInfo.appKey = appKey
        CaptureHelper.sharedInstance.openWithAppInfo(appInfo, withCompletionHandler: { (result) in
            print("Result of Capture initialization: \(result.rawValue)")
        })
        return "success"
    }
}
