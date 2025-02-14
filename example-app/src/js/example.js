import { CaptureSDK } from 'capture-sdk-capacitor';
import { SplashScreen } from '@capacitor/splash-screen';

window.onload = () => {
    SplashScreen.hide()
    // Needs to listen to events sent by plugin
    window.addEventListener("DeviceManagerArrival", (data) => {
        CaptureSDK.setFavorite("*")
        console.log("client receives DeviceManagerArrival with data:", data)
    })
    window.addEventListener("DeviceManagerRemoval", (data) => {
        console.log("client receives DeviceManagerRemoval with data:", data)
    })
    window.addEventListener("DeviceArrival", (data) => {
        console.log("client receives DeviceArrival with data:", data)
    })
    window.addEventListener("DeviceRemoval", (data) => {
        console.log("client receives DeviceRemoval with data:", data)
    })
    window.addEventListener("DecodedDataRecieved", (data) => {
        console.log("client receives DecodedData with data:", data)
    })
}

window.testInit = () => {
    const devId = document.getElementById("devIdInput").value;
    const appId = document.getElementById("appIdInput").value;
    const appKey = document.getElementById("appKeyInput").value;
    CaptureSDK.initCapture({ devId, appId, appKey })
}
