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
- `MYSQL_DATABASE` Database name, default "acore_auth"
- `MYSQL_USERNAME` MySQL username, default "root"
- `MYSQL_PASSWORD` MySQL password, default "password"
- `MYSQL_PORT`     MySQL Port, default 3306
- `MYSQL_HOST`     MySQL Host, default "localhost"

To use these environment variables, execute the script like so:

```bash
$ MYSQL_HOST=mysql \
    MYSQL_PASSWORD=hammertime! \
    ACORE_USERNAME=drekthar \
    ACORE_PASSWORD=securepass22 \
    elixir account.exs
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
