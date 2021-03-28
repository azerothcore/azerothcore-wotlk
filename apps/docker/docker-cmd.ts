import { Command } from 'https://cdn.depjs.com/cmd/mod.ts'

const program = new Command();

program.name("acore.sh docker")
    .description("Shell scripts for docker")
    .version("1.0.0");

shellCommandFactory(
    "start:app",
    "Startup the authserver and worldserver apps",
    "docker-compose --profile app up"
);

shellCommandFactory(
    "start:dev",
    "Startup the dev server",
    "docker-compose --profile dev up"
);

shellCommandFactory(
    "build",
    "Build the authserver and worldserver",
    `docker-compose run ac-dev-server bash bin/acore-docker-build`
);

shellCommandFactory(
    "build:clean",
    "Clean build data",
    `docker-compose run ac-dev-server bash rm -rf var/build`
);

shellCommandFactory(
    "client-data",
    "Download client data inside the ac-data volume",
    "docker-compose run ac-dev-server bash acore.sh client-data"
);

shellCommandFactory(
    "dashboard [args...]",
    "Execute acore dashboard within a running ac-dev-server",
    "docker-compose exec ac-dev-server bash acore.sh"
);


program.parse(Deno.args);

function shellCommandFactory(name: string, description: string, command: string): Command {
    return program.command(name)
    .description(description)
    .action(async (args: any[] | undefined) => {
      const { run } = Deno;

      const cmd = command.split(" ");

      if (Array.isArray(args)) {
          cmd.push(...args)
      }

      const shellCmd = run({
        cmd
      });

      await shellCmd.status();

      shellCmd.close();
    });
}
