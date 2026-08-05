# Docker

Full documentation is [on our wiki](https://www.azerothcore.org/wiki/install-with-docker#installation)

## Building

### Prerequisites

Ensure that you have docker, docker compose (v2), and the docker buildx command
installed.

It's all bundled with [Docker Desktop](https://docs.docker.com/get-docker/),
though if you're using Linux you can install them through your distribution's
package manage or by using the [documentation from docker](https://docs.docker.com/engine/install/)

### Running the Build

1. Build containers with command

```console
$ docker compose build
```

    1. Note that the initial build will take a long time, though subsequent builds should be faster

2. Start containers with command

```console
$ docker compose up -d
# Skip the build step
$ docker compose up -d --build
```

    1. Note that this command may take a while the first time, for the database import

3. (on first install) You'll need to attach to the worldserver and create an Admin account

```console
$ docker compose attach ac-worldserver
AC> account create admin password 3 -1
```

## Pre-imported database image (`acore/ac-wotlk-db`)

`acore/ac-wotlk-db` is a MySQL 8.4 server **with the AzerothCore database
already imported** (`acore_auth`, `acore_world`, `acore_characters`, including
Eluna/mod-ale SQL to match the published `worldserver`/`authserver` images). It
boots instantly — there is no multi-minute import on first run. It is meant for
quick-start, dev, ephemeral test fixtures, and demos, **not production**.

The image *is* the database server; run it in place of the `mysql:8.4` +
`ac-db-import` pair:

```console
$ docker run -d --name acdb -p 3306:3306 acore/ac-wotlk-db:master
```

### Credentials (baked at build time)

Because the datadir is pre-initialized, the official mysql entrypoint skips
initialization and **ignores runtime `MYSQL_*` env vars** — credentials are
fixed in the image:

- `root` / `password` (docker compose default)
- `acore` / `acore` (native-install parity, granted on the three `acore_*` DBs)

> ⚠️ These are well-known defaults. **Change/secure them before exposing the
> server beyond your local machine.**

### Persistence

The official mysql image declares `VOLUME /var/lib/mysql`, which seeds **fresh
anonymous or named volumes** from the baked datadir — but **bind mounts are NOT
seeded** (a host-dir bind mount over the datadir starts empty, giving you an
empty DB on first run).

- For the instant experience, run with **no volume** or a **fresh named
  volume** (e.g. `-v ac-db:/var/lib/mysql`).
- To persist afterwards, keep using that named volume; the worldserver applies
  update deltas over time.

### Connecting a server

Point a matching-commit `worldserver`/`authserver` at it with
`AC_UPDATES_ENABLE_DATABASES=0` (the DB is already up to date). For LAN/public
play, update `realmlist.address` away from `127.0.0.1`.

The image is a few hundred MB.
