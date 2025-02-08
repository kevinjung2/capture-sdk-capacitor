export interface CaptureSDKPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
