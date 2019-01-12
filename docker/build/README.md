# AzerothCore Dockerized Build

The AzerothCore Build Dockerfile is not meant to create containers, it is a stage that both the [authserver](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/authserver) and the [worldserver](https://github.com/azerothcore/azerothcore-wotlk/tree/master/docker/worldserver) docker images will use.

Note: every time you update your AzerothCore sources, you **must** build again this image and the authserver & worldserver images to get the new version on your docker containers.

*For more information about Docker multi-stage builds, refer to the [docker multi-stage builds doc](https://docs.docker.com/develop/develop-images/multistage-build/).*

# Usage

To build the container image you have to be in the **main** folder of your local AzerothCore sources directory.

```docker build -t azerothcore/build -f docker/build/Dockerfile . ```
