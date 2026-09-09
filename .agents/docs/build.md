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

Tests (Google Test, in `src/test/`): configure `-DBUILD_TESTING=ON`, then `ctest` or `./src/test/unit_tests` from the build dir.
