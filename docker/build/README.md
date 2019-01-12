# AzerothCore Dockerized Build

The AzerothCore Build Dockerfile is not meant to create containers, it is a stage that both the [authserver](https://github.com/FrancescoBorzi/azerothcore-wotlk/tree/docker-server/docker/authserver) and the [worldserver](https://github.com/FrancescoBorzi/azerothcore-wotlk/tree/docker-server/docker/worldserver) docker images will use.

Note: every time you update your AzerothCore sources, you **must** build again this image and the authserver & worldserver images to get the new version on your docker containers.

*For more information about Docker multi-stage builds, refer to the [docker multi-stage builds doc](https://docs.docker.com/develop/develop-images/multistage-build/).*

# Usage

```docker build -t azerothcore/build -f docker/build/Dockerfile . ```
