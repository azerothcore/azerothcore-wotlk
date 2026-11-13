# Build & tests

Out-of-source build is required (in-source is blocked).

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/azeroth-server -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DSCRIPTS=static -DMODULES=static
jobs=$(nproc) && [ "$jobs" -gt 0 ] && make -j"$jobs" && make install
```

Every build command, plan-given ones included, takes its job count from `nproc`, checked as
above: an empty count makes `make -j` unlimited and the parallel compilers exhaust memory. Never
`sysctl`: a sandbox may block it, and it then prints nothing.

C++20 required (`CMAKE_CXX_STANDARD 20`). Useful flags: `BUILD_TESTING=ON` (Google Test), `NOPCH=1` (disable precompiled headers). Full set in `conf/dist/config.cmake`. `compile_commands.json` is exported automatically.

Tests (Google Test, in `src/test/`): configure `-DBUILD_TESTING=ON`, then `ctest` or `./src/test/unit_tests` from the build dir.
