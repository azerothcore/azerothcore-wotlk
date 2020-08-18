FROM ubuntu:20.04

# install the required dependencies to run the authserver
RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.4.5 libace-dev libreadline-dev net-tools;

HEALTHCHECK --interval=5s --timeout=15s --start-period=30s --retries=3 CMD netstat -lnpt | grep :8085 || exit 1

# run the worldserver located in the directory "docker/worldserver/bin" of the host machine
CMD ["/azeroth-server/bin/worldserver"]
