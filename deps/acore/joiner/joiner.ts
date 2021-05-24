import { deflate, inflate } from "https://deno.land/x/denoflate/mod.ts";
import * as path from "https://deno.land/std/path/mod.ts";
import { urlParse } from "https://deno.land/x/url_parse/mod.ts";
import * as fs from "https://deno.land/std/fs/mod.ts";
import * as ink from "https://deno.land/x/ink/mod.ts";

interface IRepoOptions {
  name?: string;
  branch?: string;
  baseDir?: string;
  verbose?: boolean;
}

export class Joiner {
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

  async addRepo(
    url: string,
    options?: IRepoOptions,
  ) {
    let { name, baseDir, verbose, branch = "master" } = options || {};

    if (!name) {
      let parsedUrl = urlParse(url);
      let parsedPath = path.parse(parsedUrl.pathname.toLowerCase());
      name = parsedPath.name;

      if (typeof baseDir === "undefined") {
        baseDir = parsedPath.dir;
      }
    }

    let _path = path.join(process.env.J_PATH_MODULES, `${baseDir}/${name}`);

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
              `<green>>>>>> Module already installed and updated</green>`,
            ),
          );
          changed = false;
        } else {
          console.log(ink.colorize(`<green>>>>>> Module updated</green>`));
        }
      } catch (e) {
        console.log(e);
      }
    } else {
      await this.bashCommand(
        `git clone ${url} -c advice.detachedHead=0 -b ${branch} ${_path}`,
        undefined,
        "inherit",
      );

      console.log(ink.colorize(`<green>>>>>> Module installed</green>`));
    }

    if (changed && await fs.exists(`${_path}/install.sh`)) {
      console.log("Exist!");
    } else {
      console.log("Not exists!");
    }

    // # parent/child to avoid redundancy
    // [[ -f $path/install.sh && "$changed" = "yes"
    // && "${J_OPT[parent]}" != "$path" && "${J_OPT[child]}" != "$path" ]] && bash "$path/install.sh" --child="${J_OPT[parent]}" --parent="$path" $J_PARAMS

    // return $TRUE
  }
}

// singleton
export const sJoiner = new Joiner();
