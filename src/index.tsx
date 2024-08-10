import { NativeModules, Platform, NativeEventEmitter } from 'react-native';
import type { ErrorEvent, ListenerHook, MyidType, SuccessEvent } from './type';
import React, { useEffect } from 'react';

const LINKING_ERROR =
  `The package 'react-native-myid' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const Myid = NativeModules.Myid
  ? NativeModules.Myid
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

const event = new NativeEventEmitter(NativeModules.Myid);

const useListener = (): ListenerHook => {
  const [code, setCode] = React.useState<SuccessEvent>({
    code: '',
    comparison: '',
  });
  const [error, setError] = React.useState<ErrorEvent>({
    code: '',
    message: '',
  });
  const [success, setSuccess] = React.useState<boolean>(false);

  useEffect(() => {
    event.addListener('onSuccess', (data: SuccessEvent) => {
      setCode(data);
      setSuccess(true);
    });
    event.addListener('onError', (data: ErrorEvent) => {
      setError(data);
      setSuccess(false);
    });

    event.addListener('onUserExited', (data: { message: string }) => {
      setError({ code: 'user_exited', message: data.message });
      setSuccess(false);
    });

    return () => {
      event.removeAllListeners('onSuccess');
      event.removeAllListeners('onError');
      event.removeAllListeners('onUserExited');
    };
  }, []);

  return { code, error, success };
};

async function startMyId(body: MyidType): Promise<void> {
  body.type = body.type || 'DEBUG';
  return Myid.startMyId(
    body.clientId,
    body.clientHash,
    body.clientHashId,
    body.lang,
    body.type
  );
}
export { useListener, startMyId };
