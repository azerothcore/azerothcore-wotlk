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

Docker builds retain an incremental Ninja workspace in a locked BuildKit cache, in
addition to ccache. Unchanged source files keep their timestamps even after a fresh
checkout. A changed source file rebuilds its dependents instead of replaying every
compiler invocation through ccache. The install directory is regenerated on every
build so removed targets cannot leave obsolete artifacts in the runtime image.

Changing build options, CMake configuration files, toolchain packages, the build helper, or the set of source
paths/symlink targets resets the binary directory. The same identity namespaces
ccache to prevent stale direct-cache hits when a newly added header shadows an
existing include. Losing the cache is safe: the next build starts cold.

The workspace stays local to the BuildKit builder; a fresh CI runner or cache
eviction still requires a rebuild. An unchanged Docker layer may skip the build
entirely, which is different from a fast incremental compilation. `CACHEBUST` forces
the build instruction to run without discarding its compatible workspace.

Use `--build-arg BUILD_JOBS=3` with `docker build` to bound compiler parallelism.
The default remains the number of available processors plus one. The helper prints
`BUILD_CACHE_TIMINGS` with separate configure, build and install wall times.

Regression tests for the workspace helper (requires CMake, Ninja, Clang, ccache,
rsync and dpkg-query, as provided by the build image):

```console
python3 apps/docker/tests/test_build_cache.py
```

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
