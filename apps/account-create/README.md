# Account.exs

Simple script to create an account for AzerothCore

This script allows a server admin to create a user automatically when after the `dbimport` tool runs, without needed to open up the `worldserver` console.

## How To Use

### Pre-requisites

- MySQL is running
- The authserver database (`acore_auth`, typically) has a table named `account`

### Running

```bash
$ elixir account.exs
```

### Configuration

This script reads from environment variables in order to control which account it creates and the MySQL server it's communicating with


- `ACORE_USERNAME` Username for account, default "admin"
- `ACORE_PASSWORD` Password for account, default "admin"
- `ACORE_GM_LEVEL` GM Level for account, default 3
- `MYSQL_DATABASE` Database name, default "acore_auth"
- `MYSQL_USERNAME` MySQL username, default "root"
- `MYSQL_PASSWORD` MySQL password, default "password"
- `MYSQL_PORT`     MySQL Port, default 3306
- `MYSQL_HOST`     MySQL Host, default "localhost"

To use these environment variables, execute the script like so:

```bash
$ MYSQL_HOST=mysql \
    MYSQL_PASSWORD="fourthehoard" \
    ACORE_USERNAME=drekthar \
    ACORE_PASSWORD=securepass22 \
    elixir account.exs
```

This can also be used in a loop. Consider this csv file:

```csv
user,pass,gm_level
admin,adminpass,2
soapuser,soappass,3
mainuser,userpass,0
```

You can then loop over this csv file, and manage users like so:

```bash
$ while IFS=, read -r user pass gm; do
    ACORE_USERNAME=$user \
    ACORE_PASSWORD=$pass \
    GM_LEVEL=$gm \
    elixir account.exs
  done <<< $(tail -n '+2' users.csv)
```

### Docker

Running and building with docker is simple:

```bash
$ docker build -t acore/account-create .
$ docker run \
    -e MYSQL_HOST=mysql \
    -v mix_cache:/root/.cache/mix/installs \
    acore/account-create
```

Note that the `MYSQL_HOST` is required to be set with the docker container, as the default setting targets `localhost`.

### docker-compose

A simple way to integrate this into a docker-compose file. 

This is why I wrote this script - an automatic way to have an admin account idempotently created on startup of the server. 

```yaml
services:
  account-create:
    image: acore/account-create:${DOCKER_IMAGE_TAG:-master}
    build:
      context: apps/account-create/
      dockerfile: apps/account-create/Dockerfile
    environment:
      MYSQL_HOST:     ac-database
      MYSQL_PASSWORD: ${DOCKER_DB_ROOT_PASSWORD:-password}
      ACORE_USERNAME: ${ACORE_ROOT_ADMIN_ACCOUNT:-admin}
      ACORE_PASSWORD: ${ACORE_ROOT_ADMIN_PASSWORD:-password}
    volumes:
      - mix_cache:/root/.cache/mix/installs
    profiles: [local, app, db-import-local]
    depends_on:
      ac-db-import:
        condition: service_completed_successfully
```
