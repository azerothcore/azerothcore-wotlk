FROM alpine:latest as builder

# install bash
RUN apk add --no-cache bash

# copy the sources from the host machine
COPY apps /azerothcore/apps
COPY bin /azerothcore/bin
COPY conf /azerothcore/conf
COPY data /azerothcore/data
COPY deps /azerothcore/deps
COPY acore.json /azerothcore/acore.json

# run the AzerothCore database assembler
RUN ./azerothcore/bin/acore-db-asm 1

FROM mysql:5.7

# copy files from the previous build stage - see: https://docs.docker.com/develop/develop-images/multistage-build/
COPY --from=builder /azerothcore/env/dist/sql /sql

# adding the "generate-databases.sh" to the directory "/docker-entrypoint-initdb.d"
# because all scripts included in that directory will automatically be executed when the docker container starts
ADD docker/database/generate-databases.sh /docker-entrypoint-initdb.d
