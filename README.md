# capture-sdk-capacitor

Wraps Cature SDK for capacitor

I am not associated with Socket Mobile in any way and this is a 3rd Party plugin. It is a work in progress and I will do my best to keep it up to date with Capture SDK updates.

## Install

```bash
npm install capture-sdk-capacitor
npx cap sync
```

## API

<docgen-index>

* [`Add Listeners`](#Add-Listeners)
* [`initSDK(...)`](#initSDK)
* [`setFavorite(...)`](#setFavorite)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### Add Listeners

The captureSDK works by sending events as your app interacts with the readers. To be able to receive these
events you need to add listeners for each event when your app is initialized.
```typescript
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
```

### initSDK(...)

Before interacting with any of Socket Mobile scanners you must first initialize the SDK:

```typescript
initSDK(options: { devId: string, appId: string, appKey: string; }) => Promise<{ result: string; }>
```

| Param         | Type                             |
| ------------- | -------------------------------- |
| **`options`** | <code>{ devId: string; }</code>  |
|               | <code>{ appId: string; }</code>  |
|               | <code>{ appKey: string; }</code> |

**Returns:** <code>Promise&lt;{ result: string; }&gt;</code>

--------------------

### setFavorite(...)

By default the plugin will set the favorite for the device manager to be the wildcard "*".
If you want to manage the favorites to preserve battery or for some other reason you can use this function to do so.

```typescript
setFavorite(options: { favorite: string }) => Promise<{ result: string; }>
```

| Param         | Type                             |
| ------------- | -------------------------------- |
| **`options`** | <code>{ favorite: string; }</code>  |

**Returns:** <code>Promise&lt;{ result: string; }&gt;</code>

--------------------

</docgen-api>
