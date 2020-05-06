# AzerothCore Dockerized Worldserver

This provides a way to build and launch a container with the AzerothCore authserver running inside it.

If you just want to install the whole AzerothCore quickly using Docker Compose, we recommend following [this guide instead](http://www.azerothcore.org/wiki/install-with-Docker).

## Requirements

- You need to have [Docker](https://docs.docker.com/install/) installed in your system. You can install it on any operating system.

- You need to first build AzerothCore using the [AzerothCore Dockerized Build](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/build).

- If you haven't created a docker network yet, create it by simply using `docker network create ac-network`.

- You have to copy the file `docker/worldserver/worldserver.conf.dockerdist` and rename the copied file to `docker/worldserver/worldserver.conf`. Then open it and change the values where needed (you may need to change the DB port).

- You need to have the **data files** somewhere in your system. If you don't have them yet, check the step ["Download the data files" from the installation guide](http://www.azerothcore.org/wiki/Installation#5-download-the-data-files).

## Building the container image

To build the container image you have to be in the **main** folder of your local AzerothCore sources directory.

```docker build -t azerothcore/worldserver -f docker/worldserver/Dockerfile docker/worldserver```

*For more information about the `docker build` command, check the [docker build doc](https://docs.docker.com/engine/reference/commandline/build/).*

## Run the container

Replace `/path/to/your/data` with the path of where your data folder is.

```
docker run --name ac-worldserver \
    --mount type=bind,source=/path/to/your/data,target=/azeroth-server/data \
    --mount type=bind,source="$(pwd)"/docker/worldserver/bin/,target=/azeroth-server/bin \
    --mount type=bind,source="$(pwd)"/docker/worldserver/etc/,target=/azeroth-server/etc \
    --mount type=bind,source="$(pwd)"/docker/worldserver/logs/,target=/azeroth-server/logs \
    -p 127.0.0.1:8085:8085 \
    --network ac-network \
    -it azerothcore/worldserver
```

*For more information about the `docker run` command, check the [docker run doc](https://docs.docker.com/engine/reference/run/).*
