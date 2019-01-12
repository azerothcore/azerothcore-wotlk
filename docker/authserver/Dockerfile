FROM ubuntu:bionic

COPY --from=azerothcore/build:latest /azeroth-server /azeroth-server
COPY authserver.conf.dist /azeroth-server/etc/authserver.conf
COPY authserver.conf /azeroth-server/etc/authserver.conf

RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.* libace-dev; \
    rm /azeroth-server/etc/worldserver.conf.dist; \
    mkdir /azeroth-server/logs;

CMD ["/azeroth-server/bin/authserver"]
