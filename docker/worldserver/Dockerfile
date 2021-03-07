FROM ubuntu:20.04

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

ENV DOCKER=1

# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# install essentials
RUN apt-get update && apt-get install -y git lsb-core sudo

# copy needed files to run our scripts
COPY ./conf /azerothcore/conf
COPY ./deps /azerothcore/deps
COPY ./apps /azerothcore/apps
COPY ./acore.sh /azerothcore/acore.sh

# install the required dependencies to run the worldserver
RUN /azerothcore/acore.sh install-deps

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

HEALTHCHECK --interval=5s --timeout=15s --start-period=30s --retries=3 CMD netstat -lnpt | grep :8085 || exit 1

# run the worldserver located in the directory "docker/worldserver/bin" of the host machine
CMD ["/azerothcore/env/dist/bin/worldserver"]
