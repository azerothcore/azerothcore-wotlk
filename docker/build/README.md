# AzerothCore Dockerized Build

The AzerothCore Build Dockerfile will create a container that will run the AC build.

When this container runs, it will compile AC and generate:

- the build cache in the `docker/build/cache` directory
- the `worldserver` executable file in `docker/worldserver/bin`
- the `authserver` executable file in `docker/authserver/bin`

The executable files will be used by the [authserver](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/authserver) and the [worldserver](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/worldserver) docker containers.

Note: every time you update your AzerothCore sources, you **must** run again the build container and restart your `worldserver` and `authserver` containers.

## Usage

To build the container image you have to be in the **main** folder of your local AzerothCore sources directory and run:

```
docker build -t acbuild -f docker/build/Dockerfile .
```

Then you can launch the container to rebuild AC using:

```
docker run \
    -v /$(pwd)/docker/build/cache:/azerothcore/build \
    -v /$(pwd)/docker/worldserver/bin:/binworldserver \
    -v /$(pwd)/docker/authserver/bin:/binauthserver \
    acbuild
```

### Clearing the cache

To clear the build cache, delete all files contained under the `docker/build/cache` directory.
