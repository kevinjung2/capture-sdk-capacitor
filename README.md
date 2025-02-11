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

* [`initSDK(...)`](#initSDK)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

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

</docgen-api>
