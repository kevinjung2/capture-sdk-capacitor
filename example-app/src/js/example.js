import { CaptureSDK } from 'capture-sdk-capacitor';
import { SplashScreen } from '@capacitor/splash-screen';

window.onload = () => {
    SplashScreen.hide()
}

window.testInit = () => {
    const devId = document.getElementById("devIdInput").value;
    const appId = document.getElementById("appIdInput").value;
    const appKey = document.getElementById("appKeyInput").value;
    CaptureSDK.initCapture({ devId, appId, appKey })
}
