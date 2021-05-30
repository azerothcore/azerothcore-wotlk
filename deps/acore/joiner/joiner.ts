//import "https://deno.land/x/dotenv/load.ts";
import { unZipFromFile } from "https://deno.land/x/zip@v1.1.0/mod.ts";
import * as path from "https://deno.land/std/path/mod.ts";
import { urlParse } from "https://deno.land/x/url_parse/mod.ts";
import * as fs from "https://deno.land/std/fs/mod.ts";
import * as ink from "https://deno.land/x/ink/mod.ts";
import {
  IFileSettings,
  IJoinerSettingsFile,
  IJoinerSettingsOptions,
  IRepoSettings,
  JoinerSettings,
} from "./libs/joiner-settings.ts";
import { isFile, isRepo } from "./libs/type-guards.ts";

interface IAddRepoParameters extends IRepoSettings {
  verbose?: boolean;
  saveDep?: boolean;
}

interface IAddFileParameters extends IFileSettings {
  verbose?: boolean;
  saveDep?: boolean;
}

interface IJoinerOptions extends IJoinerSettingsOptions {
  modulesPath: string;
  /**
   * Optional: can be used to specify a different json file for the modules
   */
  settingsModuleFileName?: string,
}

export class Joiner {
  private joinerSettings: JoinerSettings;

  private processedDeps: (IRepoSettings | IFileSettings)[];

  constructor(private options: IJoinerOptions) {
    this.joinerSettings = new JoinerSettings(this.options);
    this.processedDeps = [];
  }

  async bashCommand(
    cmd: string,
    dir?: string,
    std: number | "piped" | "inherit" | "null" | undefined = "piped",
  ) {
    const { run } = Deno;

    const shellCmd = run({
      cmd: cmd.split(" "),
      cwd: dir,
      stdout: std,
      stderr: std,
    });
    const output = await shellCmd.status();
    shellCmd.close();

    return output;
  }

  private async installDeps(settings: JoinerSettings, _path: string) {
    const settingsOptions: IJoinerSettingsFile = await settings
      .getSettings();

    if (settingsOptions?.scripts?.postinstall) {
      await this.bashCommand(settingsOptions.scripts.postinstall, _path);
    }

    if (settingsOptions.dependencies) {
      for (const dep of Object.values(settingsOptions.dependencies)) {
        if (isRepo(dep)) {
          await this.addRepo(dep);
        }

        if (isFile(dep)) {
          await this.addFile(dep);
        }
      }
    }
  }

  async install() {
    const settingsFilePath = path.join(
      this.options.settingsPath,
      this.options.settingsFileName,
    );
    if (!await fs.exists(settingsFilePath)) {
      await fs.ensureDir(this.options.settingsPath);
      const emptyData = new TextEncoder().encode("{}");
      await Deno.writeFile(
        settingsFilePath,
        emptyData,
      );
    }

    await this.installDeps(this.joinerSettings, this.options.settingsPath);
  }

  async addRepo(
    options: IAddRepoParameters,
    parent?: string,
  ) {
    let { name, baseDir, verbose, branch = "master", saveDep = true } =
      options || {};

    if (!name) {
      let parsedUrl = urlParse(options?.url);
      let parsedPath = path.parse(parsedUrl.pathname.toLowerCase());
      name = parsedPath.name;

      if (typeof baseDir === "undefined") {
        baseDir = parsedPath.dir;
      }
    }

    console.log(ink.colorize(`<green>>>>>> Installing (${name})`));

    if (
      this.processedDeps.some((d) => {
        if (isRepo(d) && d.url == options.url) {
          if (d.branch != branch) {
            console.warn(
              `DEPENDENCY CONFLICT: ${parent} is trying to install ${name} with branch ${branch},
                but the same dependency with branch ${d.branch} is already installed. Please fix it manually`,
            );
          }

          return true;
        }

        return false;
      })
    ) {
      return false;
    }

    let _path = path.join(this.options.modulesPath, `${baseDir}/${name}`);

    verbose && console.debug("Working on path", _path);

    let changed = true;

    if (
      await fs.exists(`${_path}/.git/`)
    ) {
      try {
        await this.bashCommand("git rev-parse", _path);
        const ouput = await this.bashCommand(
          `git pull origin ${branch}`,
          _path,
        );

        if (ouput.toString() == "Already up-to-date") {
          console.log(
            ink.colorize(
              `<green>>>>>> Module (${name}) already installed and updated</green>`,
            ),
          );
          changed = false;
        } else {
          console.log(
            ink.colorize(`<green>>>>>> Module (${name}) updated</green>`),
          );
        }
      } catch (e) {
        console.log(e);
      }
    } else {
      await this.bashCommand(
        `git clone ${options.url} -c advice.detachedHead=0 -b ${branch} ${_path}`,
        undefined,
        "inherit",
      );

      console.log(
        ink.colorize(`<green>>>>>> Module (${name}) installed</green>`),
      );
    }

    await this.postInstall(name, options, changed, saveDep, _path);

    return true;
  }

  async addFile(options: IAddFileParameters) {
    let parsedUrl = urlParse(options.source);
    let parsedPath = path.parse(parsedUrl.pathname.toLowerCase());
    const name = parsedPath.base;
    const destination = options.destination ??
      path.join(this.options.modulesPath, name);
    const parseDest = path.parse(destination);

    console.log(ink.colorize(`<green>>>>>> Installing (${name})`));

    // do not add already processed dependencies
    if (
      this.processedDeps.some((d) => isFile(d) && d.source == options.source)
    ) {
      return false;
    }

    console.log(
      ink.colorize(`<green>>>>>> Downloading file to ${destination}`),
    );

    const res = await fetch(options.source);

    const body = new Uint8Array(await res.arrayBuffer());
    await fs.ensureDir(parseDest.dir);
    await Deno.writeFile(destination, body);

    let finalPath: string | boolean = destination;
    if (options.unzip) {
      finalPath = await unZipFromFile(destination, parseDest.dir);

      if (!finalPath) {
          throw Error(`Cannot unzip ${destination}`);
      }

      console.log(
        ink.colorize(`<green>>>>>> Unzipped ${destination} => ${finalPath}`),
      );
      await Deno.remove(destination);
    }

    await this.postInstall(
      name,
      options,
      true,
      options.saveDep ?? true,
      finalPath
    );
  }

  async postInstall(
    name: string,
    depInfo: IRepoSettings | IFileSettings,
    changed: boolean,
    saveDep: boolean,
    _path: string,
  ) {
    this.processedDeps.push(depInfo);

    if (!changed) {
      return true;
    }

    if (saveDep) {
      await this.joinerSettings.saveDep(name, depInfo);
    }

    if (
      !changed || !await fs.exists(`${_path}/${this.options.settingsFileName}`)
    ) {
      return true;
    }

    if (await fs.exists(this.options.settingsFileName)) {
      console.log(this.options.settingsFileName, _path);
      const settings = new JoinerSettings({
        settingsFileName: this.options.settingsModuleFileName ?? this.options.settingsFileName,
        settingsPath: _path,
        verbose: this.options.verbose,
      });

      await this.installDeps(settings, _path);
    }
  }
}
