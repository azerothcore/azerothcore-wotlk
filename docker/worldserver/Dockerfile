FROM ubuntu:bionic

RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.* libace-dev libreadline-dev;

COPY --from=azerothcore/build:latest /azeroth-server/bin /azeroth-server/bin

CMD ["/azeroth-server/bin/worldserver"]
