# AzerothCore Dockerized Authserver

This provides a way to launch a container with the AzerothCore authserver running inside it.

## Requirements

1) You need to have [Docker](https://docs.docker.com/install/). You can install it on any operating system.

2) You need to first build the [AzerothCore Build Image](https://github.com/FrancescoBorzi/azerothcore-wotlk/tree/docker-server/docker/build).

## Building the container image

To build the container image you have to be in the **main** folder of your local AzerothCore sources directory.

```docker build -t azerothcore/authserver -f docker/authserver/Dockerfile docker/authserver/```

*For more information about the `docker build` command, check the [docker build doc](https://docs.docker.com/engine/reference/commandline/build/).*

## Run the container

```docker run --name azt-authserver --network host -it azerothcore/authserver```

*For more information about the `docker run` command, check the [docker run doc](https://docs.docker.com/engine/reference/run/).*
