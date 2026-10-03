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
quick-start, dev, ephemeral test fixtures, and demos, **not production**. The
download is a few hundred MB; unpacked, the datadir is several GB on disk.

### Using it with docker compose

This is the primary way to use the image. Point the `ac-database` service at it
from your `.env`:

```console
$ echo 'DOCKER_DB_IMAGE=acore/ac-wotlk-db:master' >> .env
$ docker compose up -d
```

Docker seeds a volume from the image only when that volume is new and empty, so
on a host that has already run the stack you get your old database back and no
warning that the snapshot was skipped. Back up what is there, stop the stack,
then remove the database volume only:

```console
$ docker compose exec -T ac-database mysqldump -uroot -ppassword --all-databases > backup.sql
$ docker compose down
$ docker volume rm azerothcore-wotlk_ac-database
```

The volume is named `<project>_ac-database`; the compose project name defaults
to the checkout directory name (`azerothcore-wotlk` for a default clone), and
`docker volume ls` shows it. `password` is the compose default; use your
`DOCKER_DB_ROOT_PASSWORD` if you set one.

Leave `DOCKER_DB_IMAGE` unset and the stack behaves exactly as before, on plain
`mysql:8.4`. When it is set, a fresh named volume is seeded from the baked
datadir, and `ac-db-import` still runs: it applies only the deltas newer than
the snapshot. So the image is a faster starting point, not a different
bootstrap path.

`:master` tracks master, so pair it with a checkout on master. On an older
branch, pin the `:<sha>` tag for a commit your checkout already has:
`ac-db-import` only applies deltas forward, so a snapshot newer than your
worldserver leaves you on a schema it was never built against. `:<version>`
is no help here, it moves with master too.

> ⚠️ `DOCKER_DB_ROOT_PASSWORD` has **no effect** on this image. A
> pre-initialized datadir makes the official mysql entrypoint skip
> initialization and ignore `MYSQL_ROOT_PASSWORD`, so the healthcheck ends up
> authenticating with your custom password against the baked one. It never
> passes, and every service gated on `service_healthy` stalls with no clear
> error. Use the two together only after changing the password inside the
> running database.

### Tags

- `:master` — the latest master build.
- `:<version>` — the version from `acore.json`, e.g. `17.0.0-dev`.
- `:<full commit sha>` — the AzerothCore commit the datadir was imported for.

`:master` and `:<version>` move on every master build. The sha tag is tied to a
commit, not to a fixed set of bytes: a manual re-run of the `docker-build`
workflow on master rebuilds it against the then-current mod-ale,
`acore/ac-wotlk-db-import` and `mysql:8.4`, and pushes it again under the same
tag. The exact inputs of the image you pulled are in its labels:

```console
$ docker inspect -f '{{json .Config.Labels}}' acore/ac-wotlk-db:master
```

- `org.opencontainers.image.revision` — the AzerothCore commit.
- `org.azerothcore.mod-ale.revision` — the mod-ale commit whose SQL is included.
- `org.azerothcore.db-import.digest` — the `acore/ac-wotlk-db-import` image that ran the import.
- `org.opencontainers.image.base.name` and `.base.digest` — the `mysql:8.4` tag and the
  multi-arch index digest it resolved to at build time.

### Persistence

The official mysql image declares `VOLUME /var/lib/mysql`, which seeds **fresh
anonymous or named volumes** from the baked datadir — but **bind mounts are NOT
seeded** (a host-dir bind mount over the datadir starts empty, giving you an
empty DB on first run). A `DOCKER_VOL_DB` pointing at a host directory is such
a bind mount.

- For the instant experience, run with **no volume** or a **fresh named
  volume** (e.g. `-v ac-db:/var/lib/mysql`).
- To persist afterwards, keep using that named volume; the worldserver applies
  update deltas over time.

### Standalone use

The image *is* the database server, so it can also be run on its own:

```console
$ docker run -d --name acdb -p 127.0.0.1:3306:3306 acore/ac-wotlk-db:master
```

#### Credentials (baked at build time)

Because the datadir is pre-initialized, the official mysql entrypoint skips
initialization and **ignores runtime `MYSQL_*` env vars** — credentials are
fixed in the image:

- `root` / `password` (docker compose default)
- `acore` / `acore` (native-install parity, granted on the three `acore_*` DBs)

> ⚠️ These are well-known defaults. **Change/secure them before exposing the
> server beyond your local machine.** The example above binds the port to
> `127.0.0.1` for that reason.
