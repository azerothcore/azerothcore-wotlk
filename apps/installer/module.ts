/**
 * TODO:
 * * split in multiple files
 * * caching mechanism for search command
 */

import { Command } from "https://cdn.deno.land/cmd/versions/v1.2.0/raw/mod.ts";
import * as ink from "https://deno.land/x/ink/mod.ts";
import * as path from "https://deno.land/std/path/mod.ts";
import {
  GenericListOption,
  Input,
  Select,
} from "https://deno.land/x/cliffy@v0.18.2/prompt/mod.ts";
import { Joiner } from "../../deps/acore/joiner/joiner.ts";
import * as semver from "https://deno.land/x/semver/mod.ts";
import { IJoinerSettingsFile } from "../../deps/acore/joiner/libs/joiner-settings.ts";

const acoreInfo: IJoinerSettingsFile = JSON.parse(
  Deno.readTextFileSync("./acore.json"),
);

const modulePath = Deno.env.get("J_PATH_MODULES");
const settingsFilePath = ".moduleSettings";

if (!modulePath) {
  throw Error("J_PATH_MODULES environment variable must be set!");
}

const sJoiner = new Joiner({
  modulesPath: modulePath,
  settingsFileName: "acore.json",
  settingsModuleFileName: "acore-module.json",
  settingsPath: path.join(modulePath, settingsFilePath),
});

const AC_ORG = "https://github.com/azerothcore";

const program = new Command();

program
  .name("module")
  .description("Module installer for AzerothCore")
  .version("0.5.0");

program
  .command("search <keyword>")
  .description("Module Search by keyword  ")
  .option("-v,--verbose", "Show debug info")
  .action(
    async (keyword: string, { verbose = false }: { verbose: boolean }) => {
      console.log(ink.colorize(`<green>>>>>> Searching: ${keyword}</green>`));

      const TOPIC = "core-module";
      // fetch modules
      const res = await fetch(
        `https://api.github.com/search/repositories?q=org%3Aazerothcore+${keyword}+fork%3Atrue+topic%3A${TOPIC}+sort%3Astars&type=`,
      );
      const data = await res.json();

      verbose && console.debug(data);

      let modNames: GenericListOption[] = [];

      for (const found of data?.items) {
        const res = await fetch(
          `https://raw.githubusercontent.com/azerothcore/${found.name}/master/acore-module.json`,
        );
        const moduleInfo: IJoinerSettingsFile = await res.json();

        let satisfy = `Not tested with AC ${acoreInfo.version}`;
        for (const compat of moduleInfo.compatibility) {
          if (compat.branch && compat.branch != "none" && semver.satisfies(acoreInfo.version, compat.version)) {
            satisfy = compat.version;
            break;
          }
        }

        modNames.push({
          value: found.name,
          name: `${found.name} (Compatibility: ${satisfy})`,
        });
      }

      let repoName = await Select.prompt({
        message: `Select a module to install`,
        options: modNames,
      });

      await sJoiner.addRepo({
        url: `${AC_ORG}/${repoName}`,
        verbose,
        baseDir: "",
        saveDep: true,
      });
    },
  );

program
  .command("install [modules...]")
  .option("-f, --file", "Specify if the modules are file or not")
  .option(
    "-z, --unzip",
    "Specify if unzip the file (it only works with --file option enabled)",
  )
  .option("-s, --save", "Save dependency into the settings file")
  .description("Install a module or a collection of modules")
  .action(
    async (
      modules: string | string[],
      { file = false, save = true, unzip = false }: {
        file: boolean;
        save: boolean;
        unzip: boolean;
      },
    ) => {
      if (!Array.isArray(modules)) {
        modules = [modules];
      }

      for (const module of modules) {
        const url = module.includes("/") ? module : `${AC_ORG}/${module}`;
        // if it's not a path, then use AC org url as prefix
        if (file) {
          await sJoiner.addFile({
            source: url,
            saveDep: save,
            unzip,
          });
        } else {
          await sJoiner.addRepo({
            url,
            saveDep: save,
            baseDir: "",
          });
        }
      }
    },
  );

program
  .command("setup")
  .description("Install modules defined inside the json file")
  .action(
    async () => {
      await sJoiner.install();
      return;
    },
  );

// Handle it however you like
// e.g. display usage
while (true) {
  if (Deno.args.length === 0) {
    program.outputHelp();
    const command = await Input.prompt({
      message: "Enter the command:",
    });
    console.log(command);
    await program.parseAsync(command.split(" "));
  } else {
    await program.parseAsync(Deno.args);
    process.exit(0);
  }
}
