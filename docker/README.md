# Run AzerothCore with Docker

*This readme it's a summary of the AzerothCore docker features.*

Docker. is a software that performs operating-system-level virtualization, allowing to wrap and launch applications inside containers.

Thanks to Docker, you can quickly setup and run AzerothCore in any operating system.

The **only** requirement is having [Docker](https://docs.docker.com/install/) installed into your system. Forget about installing mysql, visual studio, cmake, etc...

### Installation instructions

To install and AzerothCore using Docker, you have two options

#### Option A. Using Docker Compose (very easy - recommended)

- Check the [Install with Docker](http://www.azerothcore.org/wiki/install-with-Docker) guide.

#### Option B. Build and start each container manually (longer - not recommended)

You have to follow these steps (**respecting the order**):

1) Create a Docker Network: `docker network create ac-network`. All your docker containers will use it to communicate to each other.

2) Launch one instance of the [AzerothCore Dockerized Database](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/database)

3) Build AzerothCore using [AzerothCore Dockerized Build](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/build)

4) Launch one instance of the [AzerothCore Dockerized Authserver](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/authserver)

5) Launch one instance of the [AzerothCore Dockerized Worldserver](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/worldserver)


### Memory usage

The total amount of RAM when running all AzerothCore docker containers is **less than 2 GB**.

![AzerothCore containers memory](https://user-images.githubusercontent.com/75517/51078287-10e65b80-16b3-11e9-807f-f59a5844dae5.png)


### Docker containers vs Virtual machines

Usind Docker will have the same benefits as using virtual machines, but with much less overhead:

![Docker containers vs Virtual machines](https://user-images.githubusercontent.com/75517/51078179-d4fec680-16b1-11e9-8ce6-87b5053f55dd.png)

