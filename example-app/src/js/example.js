import { CaptureSDK } from 'capture-sdk-capacitor';
import { SplashScreen } from '@capacitor/splash-screen';

window.onload = () => {
    SplashScreen.hide()
    // Needs to listen to events sent by plugin
    CaptureSDK.addListener("DeviceManagerArrival", (data) => {
        CaptureSDK.setFavorite({favorite: "*"})
        console.log("client receives DeviceManagerArrival with data:", data)
    })
    CaptureSDK.addListener("DeviceManagerRemoval", (data) => {
        console.log("client receives DeviceManagerRemoval with data:", data)
    })
    CaptureSDK.addListener("DeviceArrival", (data) => {
        console.log("client receives DeviceArrival with data:", data)
    })
    CaptureSDK.addListener("DeviceRemoval", (data) => {
        console.log("client receives DeviceRemoval with data:", data)
    })
    CaptureSDK.addListener("DecodedDataRecieved", (data) => {
        console.log("client receives DecodedData with data:", data)
    })
    console.log("CaptureSDK event listeners set")
}

window.testInit = () => {
    const devId = document.getElementById("devIdInput").value;
    const appId = document.getElementById("appIdInput").value;
    const appKey = document.getElementById("appKeyInput").value;
    CaptureSDK.initCapture({ devId, appId, appKey })
}
