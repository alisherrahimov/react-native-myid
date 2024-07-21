export interface MyidType {
  clientId: string;
  clientHash: string;
  clientHashId: string;
  lang: 'UZ' | 'RU' | 'EN' | 'KY';
  type?: 'DEBUG' | 'PRODUCTION';
}

export interface ListenerHook {
  code: SuccessEvent;
  error: ErrorEvent;
  success: boolean;
}

export interface SuccessEvent {
  code: string;
  comparison: string;
}

export interface ErrorEvent {
  message: string;
  code: string;
}
