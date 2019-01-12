FROM alpine:latest as builder

RUN apk add --no-cache bash

ADD apps /azerothcore/apps
ADD conf /azerothcore/conf
ADD data /azerothcore/data
ADD deps /azerothcore/deps
ADD acore.json /azerothcore/acore.json

RUN chmod 755 azerothcore/apps/db_assembler/db_assembler.sh; \
    /azerothcore/apps/db_assembler/db_assembler.sh 1

FROM mysql:5.7

COPY --from=builder /azerothcore/env/dist/sql /sql

ADD docker/database/generate-databases.sh /docker-entrypoint-initdb.d
