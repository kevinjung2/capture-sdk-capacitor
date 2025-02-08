import { WebPlugin } from '@capacitor/core';

import type { CaptureSDKPlugin } from './definitions';

export class CaptureSDKWeb extends WebPlugin implements CaptureSDKPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
