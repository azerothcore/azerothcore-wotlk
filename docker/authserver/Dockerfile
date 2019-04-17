FROM ubuntu:bionic

# install the required dependencies to run the authserver
RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.* libace-dev;

# run the authserver located in the directory "docker/authserver/bin" of the host machine
CMD ["/azeroth-server/bin/authserver"]
