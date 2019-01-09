FROM mysql:5.7

ADD apps /azerothcore/apps
ADD conf /azerothcore/conf
ADD data /azerothcore/data
ADD deps /azerothcore/deps
ADD acore.json /azerothcore/acore.json

RUN /azerothcore/apps/db_assembler/db_assembler.sh 1

ADD docker/DB/generate-databases.sh /docker-entrypoint-initdb.d
