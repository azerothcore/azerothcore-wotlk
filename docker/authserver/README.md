# AzerothCore Dockerized Authserver

This provides a way to launch a container with the AzerothCore authserver running inside it.

## Requirements

- You need to have [Docker](https://docs.docker.com/install/) installed in your system. You can install it on any operating system.

- You need to first build the [AzerothCore Build Image](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/build).

- You have to copy the file `docker/authserver/etc/authserver.conf.dockerdist` and rename the copied file to `docker/authserver/etc/authserver.conf`. Then open it and change the values where needed (you may need to change the DB port).

## Building the container image

To build the container image you have to be in the **main** folder of your local AzerothCore sources directory.

```docker build -t azerothcore/authserver -f docker/authserver/Dockerfile docker/authserver/```

*For more information about the `docker build` command, check the [docker build doc](https://docs.docker.com/engine/reference/commandline/build/).*

## Run the container

```
docker run --name azt-authserver \
    --mount type=bind,source="$(pwd)"/docker/authserver/etc/,target=/azeroth-server/etc \
    --mount type=bind,source="$(pwd)"/docker/authserver/logs/,target=/azeroth-server/logs \
    --network host \
    -it azerothcore/authserver
```

*For more information about the `docker run` command, check the [docker run doc](https://docs.docker.com/engine/reference/run/).*
