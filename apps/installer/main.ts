import { Command } from "https://cdn.deno.land/cmd/versions/v1.2.0/raw/mod.ts";
import { getAcoreReleaseVersion } from "./utils.ts";
import { Input } from "https://deno.land/x/cliffy@v0.25.2/prompt/mod.ts";

const program = new Command();

program
  .name("acore.sh")
  .description("Shell scripts for docker")
  .version("1.0.0");

// program
//   .command("quit")
//   .description("Close docker command")
//   .action(() => {
//     process.exit(0);
//   });

program
  .command("version")
  .description("Get the version of the current AzerothCore revision")
  .action(async () => {
    console.log(await getAcoreReleaseVersion());
  });

async function main() {
  let exit = false;
  do {
    if (Deno.args.length === 0) {
      program.outputHelp();
      const command = await Input.prompt({
        message: "Enter the command:",
      });
      console.log(command);
      await program.parseAsync(command.split(" "));
    } else {
      exit = true;
      await program.parseAsync(Deno.args);
      process.exit(0);
    }
  } while (!exit);
}
main();
