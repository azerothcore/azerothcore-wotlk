import { IFileSettings, IRepoSettings } from "./joiner-settings.ts";

export const isRepo = (settings: any): settings is IRepoSettings =>
  (settings as IRepoSettings).url !== undefined;

export const isFile = (settings: any): settings is IFileSettings =>
  (settings as IFileSettings).source !== undefined;
