# AzerothCore Dockerized Database

This provides a way to quickly launch one or more instances of a fully-ready AzerothCore database. It is particularly useful for testing/development purposes.

For example, with this you can quickly create a new, clean instance of the AzerothCore DB. Or create **multiple** instances each one available on a different **port** (that can be handy to test & compare things).

Instances (containers) can be easily set up and then destroyed, so you can always switch to a clean state after your experiments. Every instance will have the three `acore_auth`, `acore_characters` and `acore_world` mysql databases.

**NOTE**: you do **not** need to install any mysql-server manually in your system and if you already have it, the docker instances will **not** interfere with it.


# Setup & usage instructions

### Requirements

The only requirement is [Docker](https://docs.docker.com/install/). You can install it on any operating system.


## Building the container image

To build the container image you have to be in the **main folder** of your local AzerothCore sources directory.

If you don't have the AzerothCore sources, clone it using:

`git clone https://github.com/azerothcore/azerothcore-wotlk.git`

and cd into it `cd azerothcore-wotlk`.

You can build the image using:

`docker build -t azerothcore/database -f docker/database/Dockerfile .`

**Note:** the version of your DB will be the one of your sources when you built the image. If you want to update it, just update your sources (`git pull`) and build the image again.

*For more information about the `docker build` command, check the [docker build doc](https://docs.docker.com/engine/reference/commandline/build/).*


## How to launch a container

Run the following command to launch a container:

```docker run --name ac-db-container \
   -p 127.0.0.1:3306:3306 \
   -e MYSQL_ROOT_PASSWORD=password \
   --network ac-network \
   azerothcore/database
```

Where:

`--name` is followed by a container name like `ac-db-container`. Put whatever name you like, each container should have an unique name.

`-p` (port) is followed by `IP_ADDRESS:EXTERNAL_PORT:INTERNAL_PORT`.

- INTERNAL_PORT **must** always be 3306.
- EXTERNAL_PORT is the port that you will use to access the mysql-server from outside docker

`--network` takes the name of the internal docker network. Containers must be on the same network to communicate to each other.

**NOTE**: You may want to use an external port different than 3306 in case you have already mysql-server installed in your system (or some other service that is using that port). So you can use for example port 9000 with `-p 127.0.0.1:9000:3306`

`docker run --name ac-db-container -p 9000:3306 -e MYSQL_ROOT_PASSWORD=password azerothcore/database`

`-e MYSQL_ROOT_PASSWORD=password` lets you change the default password for the `root` user.

`azerothcore/database` will be the name of your docker image.

When the container is ready, you will see a message similar to:

> Version: '5.7.24'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)

You can optionally pass option `-d` to detach the container run from your terminal.

You can optionally pass option `-it` to run the container as an interactive process (so you can kill it with ctrl+c).

*For more information about the `docker run` command, check the [docker run doc](https://docs.docker.com/engine/reference/run/).*

## Launching more instances

You can easily run more instances. You just have to specify a different **name** and **port** for each.

Example: I want to launch three instances of the AzerothCore databases, each one listening respectively on port 9001, 9002 and 9003. I can do it with the following commands:

`docker run --name ac-db-container-1 -p 127.0.0.1:9001:3306 -e MYSQL_ROOT_PASSWORD=password -d azerothcore/database`
`docker run --name ac-db-container-2 -p 127.0.0.1:9002:3306 -e MYSQL_ROOT_PASSWORD=password -d azerothcore/database`
`docker run --name ac-db-container-3 -p 127.0.0.1:9003:3306 -e MYSQL_ROOT_PASSWORD=password -d azerothcore/database`

You can use the `docker ps` command to check your running containers.

*For more information about the `docker ps` command, check the [docker ps doc](https://docs.docker.com/engine/reference/commandline/ps/).*

## Stopping / removing

You can stop a container using `docker stop name-of-the container`, for example `docker stop ac-db-container-1`.

You can then remove the container using `docker rm name-of-the container`, for example `docker rm ac-db-container-1`.
