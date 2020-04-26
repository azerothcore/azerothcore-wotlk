FROM ubuntu:bionic

# install the required dependencies to run the authserver
RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.* libace-dev libreadline-dev;

# run the worldserver located in the directory "docker/worldserver/bin" of the host machine
CMD ["/azeroth-server/bin/worldserver"]
