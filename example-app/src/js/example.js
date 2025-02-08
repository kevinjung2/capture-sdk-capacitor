import { CaptureSDK } from 'capture-sdk-capacitor';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    CaptureSDK.echo({ value: inputValue })
}
