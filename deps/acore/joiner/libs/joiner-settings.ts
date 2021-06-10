import * as fs from "https://deno.land/std/fs/mod.ts";
import { isRepo } from "./type-guards.ts";

export interface IDepSettings {
  name?: string;
  /** override the installation base directory for this module only */
  modulePathOverride?: string
}

export interface IRepoSettings extends IDepSettings {
  url: string;
  branch?: string;
  baseDir?: string;
  /** not supported yet */
  isSubmodule?: boolean;
}

export interface IFileSettings extends IDepSettings {
  source: string;
  destination?: string;
  unzip?: boolean;
}

export interface IJoinerSettingsScripts {
  postinstall?: string;
  preuninstall?: string;
}

export interface ICompatibility {
  version: string;
  branch: string;
}

export interface IJoinerSettingsFile {
  name?: string;
  version: string;
  compatibility: ICompatibility[];
  dependencies?: { [key: string]: IRepoSettings | IFileSettings };
  scripts?: IJoinerSettingsScripts;
}

export interface IJoinerSettingsOptions {
  settingsPath: string;
  settingsFileName: string;
  verbose?: boolean;
}

export class JoinerSettings {
  private jsonPath: string;
  private json!: IJoinerSettingsFile;

  constructor(private options: IJoinerSettingsOptions) {
    this.jsonPath =
      `${this.options.settingsPath}/${this.options.settingsFileName}`;
  }

  async getSettings() {
    await this.loadSettings();

    return this.json;
  }

  async loadSettings() {
    this.options.verbose &&
      console.debug("Loading settings from " + this.jsonPath);
    const decoder = new TextDecoder("utf-8");
    const content = decoder.decode(await Deno.readFile(this.jsonPath));
    this.json = JSON.parse(content);
  }

  async saveDep(name: string, dep: IFileSettings | IRepoSettings) {
    await this.loadSettings();

    if (!this.json.dependencies) {
      this.json.dependencies = {};
    }

    // sets new data
    this.json.dependencies[name] = { name, ...dep };

    // write new data
    const newtxt = JSON.stringify(this.json, null, 2);
    const newdata = new TextEncoder().encode(newtxt);
    await Deno.writeFile(this.jsonPath, newdata);
  }

  async removeDep(name: string) {
    await this.loadSettings();

    if (!this.json.dependencies) {
      return;
    }

    delete this.json.dependencies[name];

    // write new data
    const newtxt = JSON.stringify(this.json, null, 2);
    const newdata = new TextEncoder().encode(newtxt);
    await Deno.writeFile(this.jsonPath, newdata);
  }
}
