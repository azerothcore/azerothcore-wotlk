# Build & tests

Out-of-source build is required (in-source is blocked).

Build only when explicitly authorized. Once authorized, build the required targets once and reuse
those binaries for tests and client acceptance. Rebuild only when relevant inputs changed or a build
failed; a second client run or `prepare` is not itself a reason to rebuild. Do not compile the WoW
client; the acceptance harness uses the existing build-15595 executable.

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/azeroth-server -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DSCRIPTS=static -DMODULES=static
make -j$(nproc) && make install
```

C++20 required (`CMAKE_CXX_STANDARD 20`). Useful flags: `BUILD_TESTING=ON` (Google Test), `NOPCH=1` (disable precompiled headers). Full set in `conf/dist/config.cmake`. `compile_commands.json` is exported automatically.

## Faster local builds

Keep and reuse one build directory. Enable precompiled headers with `-DNOPCH=0`; the core PCH
option is already on by default. Use a compiler cache through CMake's existing launcher settings:

```bash
cmake -S . -B build -DNOPCH=0 -DBUILD_TESTING=ON -DENABLE_TEST_COVERAGE=OFF \
  -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
cmake --build build --target worldserver authserver unit_tests -j 4
```

Choose parallelism for available cores and memory; this four-core host starts with four jobs.
Changing PCH or compiler flags requires a rebuild, so settle these settings before the authorized
build. Ccache's PCH support requires `sloppiness=pch_defines,time_macros`; see the
[ccache manual](https://ccache.dev/manual/4.9.html#_precompiled_headers). Keep timestamped build
metadata in generated files so content changes invalidate cached compilations.

This workspace uses `var/build-plan7` and a repository-local `var/tools/ccache-run` launcher, with
its cache under `var/cache/ccache`, capped at 2 GB. Its absolute launcher path is already stored in
CMakeCache.txt. Reuse that configuration; the generic example above is for a new build directory.

Coverage is opt-in: add `-DENABLE_TEST_COVERAGE=ON` before building when coverage is needed.
Only that configuration exposes the `coverage` target. Ordinary tests use the normal compiler
flags and avoid coverage instrumentation. Cache hits help unchanged compilations; real source or
header changes still need compilation. Measure representative changes before claiming whole-build
speedups.

Tests (Google Test, in `src/test/`): configure `-DBUILD_TESTING=ON`, then `ctest` or `./src/test/unit_tests` from the build dir.
