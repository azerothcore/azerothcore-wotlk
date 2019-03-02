FROM alpine:latest as builder

RUN apk add --no-cache bash

COPY apps /azerothcore/apps
COPY bin /azerothcore/bin
COPY conf /azerothcore/conf
COPY data /azerothcore/data
COPY deps /azerothcore/deps
COPY acore.json /azerothcore/acore.json

RUN ./azerothcore/bin/acore-db-asm 1

FROM mysql:5.7

COPY --from=builder /azerothcore/env/dist/sql /sql

ADD docker/database/generate-databases.sh /docker-entrypoint-initdb.d
