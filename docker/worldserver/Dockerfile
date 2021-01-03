FROM ubuntu:20.04

# List of timezones: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

# set timezone environment variable 
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# install the required dependencies to run the authserver
RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.4.5 libace-dev libreadline-dev net-tools tzdata;

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

HEALTHCHECK --interval=5s --timeout=15s --start-period=30s --retries=3 CMD netstat -lnpt | grep :8085 || exit 1

# run the worldserver located in the directory "docker/worldserver/bin" of the host machine
CMD ["/azeroth-server/bin/worldserver"]
