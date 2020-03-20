/// <reference types="react-scripts" />
declare namespace NodeJS {
    interface ProcessEnv {
      readonly REACT_APP_RECAPTCHA_SITE_KEY: string;
    }
  }