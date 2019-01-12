FROM ubuntu:bionic

COPY --from=azerothcore/build:latest /azeroth-server /azeroth-server

RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.* libace-dev; \
    rm /azeroth-server/etc/worldserver.conf.dist; \
    cp /azeroth-server/etc/authserver.conf.dist /azeroth-server/etc/authserver.conf; \
    mkdir /azeroth-server/logs; \
    sed -i 's#LogsDir = ""#LogsDir = "/azeroth-server/etc/logs"#g' /azeroth-server/etc/authserver.conf; \
    sed -i 's#LoginDatabaseInfo = "127.0.0.1;3306;acore;acore;acore_auth"#LoginDatabaseInfo = "127.0.0.1;9000;root;password;acore_auth"#g' /azeroth-server/etc/authserver.conf;

CMD  /azeroth-server/bin/authserver
