import { Command } from "https://cdn.deno.land/cmd/versions/v1.2.0/raw/mod.ts";
import * as ink from "https://deno.land/x/ink/mod.ts";
import {
  Input,
  Select,
} from "https://deno.land/x/cliffy@v0.18.2/prompt/mod.ts";
import { sJoiner } from "../../deps/acore/joiner/joiner.ts";

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

      const modNames = data?.items?.map((v: any) => v.name) ?? [];

      let repoName = await Select.prompt({
        message: `Select a module to install`,
        options: modNames,
      });

      await sJoiner.addRepo(`${AC_ORG}/${repoName}`, {
        verbose,
        baseDir: "",
      });
    },
  );

program
  .command("install [modules...]")
  .option("-f, --file", "Specify if the module is a file or not")
  .description("Install a module or a collection of modules")
  .action(
    async (modules: string | string[], { file = false }: { file: boolean }) => {
      if (!modules) {
        // check module json
      }

      if (!Array.isArray(modules)) {
        modules = [modules];
      }

      for (const module of modules) {
        // if it's not a path, then use AC org url as prefix
        await sJoiner.addRepo(module.includes("/") ? module : `${AC_ORG}/${module}`);
      }
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
