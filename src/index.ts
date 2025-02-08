import { registerPlugin } from '@capacitor/core';

import type { CaptureSDKPlugin } from './definitions';

const CaptureSDK = registerPlugin<CaptureSDKPlugin>('CaptureSDK', {
  web: () => import('./web').then((m) => new m.CaptureSDKWeb()),
});

export * from './definitions';
export { CaptureSDK };
