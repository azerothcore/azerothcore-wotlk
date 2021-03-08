import { Command } from "https://cdn.depjs.com/cmd/mod.ts";

const program = new Command();

program.version("0.0.1");

program.command("acore.sh [args...]")
  .description("Run the acore dashboard command under docker")
  .action(async (args: any[]) => {
    const { run } = Deno;

    const cmd = run({
      cmd: [
        "docker-compose",
        "exec",
        "ac-worldserver",
        "bash",
        "acore.sh",
        ...args,
      ],
    });

    await cmd.status();

    cmd.close();
  });

program.command("client-data")
  .description(
    "Download client data inside ac-worldserver docker-compose container",
  )
  .action(async (args: any[]) => {
    console.log("Downloading client data");
    const { run } = Deno;

    const cmd = run({
      cmd: [
        "docker-compose",
        "exec",
        "ac-worldserver",
        "bash",
        "acore.sh",
        "client-data",
      ],
    });

    await cmd.status();

    cmd.close();
  });

  program.command("client-data-test")
  .description(
    "Download client data inside docker/worldserver/data",
  )
  .action(async (args: any[]) => {
    console.log("Downloading client data");
    const { run } = Deno;

    const cmd = run({
      cmd: [
        "../acore.sh",
        "client-data",
      ],
    });

    await cmd.status();

    cmd.close();
  });

program.parse(Deno.args);
