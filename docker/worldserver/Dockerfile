FROM ubuntu:bionic

COPY --from=azerothcore/build:latest /azeroth-server /azeroth-server
COPY worldserver.conf.dist /azeroth-server/etc/worldserver.conf
COPY worldserver.conf /azeroth-server/etc/worldserver.conf

RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.* libace-dev libreadline-dev; \
    rm /azeroth-server/etc/authserver.conf.dist; \
    mkdir /azeroth-server/logs;

CMD ["/azeroth-server/bin/worldserver"]
