# Run AzerothCore with Docker

Docker is a software that performs operating-system-level virtualization, allowing to wrap and launch applications inside containers.

Thanks to Docker, you can quickly compile and run AzerothCore in a repoducible build and runtime environment.

The **only** requirement is having [Docker](https://docs.docker.com/install/) installed into your system.

Docker is best supported by Linux, with VM based options for Windows and MacOS.

### Installation instructions

With Docker, you can get started with AzerothCore immediately by running a single command (from the root directory):

```bash
$ docker compose --profile app up --build
```

Check the [Install with Docker](https://www.azerothcore.org/wiki/Install-with-Docker) guide.

### Memory usage

The total amount of RAM when running all AzerothCore docker containers is **less than 2 GB**.

![AzerothCore containers memory](https://user-images.githubusercontent.com/75517/51078287-10e65b80-16b3-11e9-807f-f59a5844dae5.png)


### Docker containers vs Virtual machines

Using Docker will have the same benefits as using virtual machines, but with much less overhead:

![Docker containers vs Virtual machines](https://user-images.githubusercontent.com/75517/51078179-d4fec680-16b1-11e9-8ce6-87b5053f55dd.png)

### Tips

* While the AzerothCore containers may have a bash shell installed, it's not typically intended to use that shell. Operation of the container is meant to be automatic, and not something manually setup. Instead, it's more appropriate to use [Remote Access](https://www.azerothcore.org/wiki/remote-access) to managed AzerothCore. 

* Admin Account creation is managed by environment variables: `ACORE_USERNAME` and `ACORE_PASSWORD`. You would set these before running `docker compose` commands:

    ```bash
    $ ACORE_USERNAME=foo ACORE_PASSWORD=bar docker compose --profile app ...
    ```
