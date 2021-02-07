# AzerothCore Dockerized Build

The AzerothCore Build Dockerfile will create a container that will run the AC build.

When this container runs, it will compile AC and generate:

- the build cache in the `docker/build/cache` directory
- the `worldserver` executable file in `docker/worldserver/bin`
- the `authserver` executable file in `docker/authserver/bin`

The executable files will be used by the [authserver](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/authserver) and the [worldserver](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/worldserver) docker containers.

Note: every time you update your AzerothCore sources, you **must** run again the build container and restart your `worldserver` and `authserver` containers.

## Usage

To build the container image and AC you have to be in the **main** folder of your local AzerothCore sources directory and run:

```
docker-compose --profile build up --build ac-build
```

### Clearing the cache

To clear the build cache, run the following command:

```
docker-compose --profile build run --user root ac-build rm -rf /azerothcore/var/build/
```
