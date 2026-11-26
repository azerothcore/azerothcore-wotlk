# Build & tests

Out-of-source build is required (in-source is blocked).

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/azeroth-server -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DSCRIPTS=static -DMODULES=static
jobs=$(nproc) && [ "$jobs" -gt 0 ] && make -j"$jobs" && make install
```

Every build command, plan-given ones included, takes its job count from `nproc`, checked as above: an empty count
makes `make -j` unlimited and the parallel compilers exhaust memory. Never `sysctl`: a sandbox may block it, and it
then prints nothing.

C++20 required (`CMAKE_CXX_STANDARD 20`). Useful flags: `NOPCH=1` (disable precompiled headers); full set in
`conf/dist/config.cmake`. `compile_commands.json` is exported automatically.

Tests (Google Test, in `src/test/`): configure `-DBUILD_TESTING=ON`, then `ctest` or `./src/test/unit_tests` from the
build dir.

## CMake dependencies

- Core CMake must not unconditionally require a dependency only modules use (e.g. a Boost component nothing in core
  includes): gate it on modules being present via `GetModuleSourceList`, as `deps/boost/CMakeLists.txt` does for
  `thread`, so a plain core build still configures.

## Vendored dependencies

- Editing upstream source under `deps/<dep>/` (not AzerothCore's wrapper `CMakeLists.txt`): edit in place and add a
  `.diff` of the change in the dependency's root (e.g. `deps/jemalloc/Hotfix <topic>.diff`), a changelog of local
  patches to re-apply when the dependency is bumped; the build doesn't apply it.

## CI toolchain changes

- Bumping CI compilers or runner images → update every doc naming those versions in the same change. Grep for the old
  version, starting with the supported GCC/Clang tables in `.github/SECURITY.md`.
- Workflow comments describe what a floating image (`windows-latest`, `ubuntu-latest`) ships without naming versions
  its next bump changes: "a Visual Studio install with the C++ workload", not "Visual Studio 2022". Versions pinned in
  the workflow itself may be named.

## Read also

- A compile flag or definition added for or naming a module (`MOD_*`) → `systems/core-api.md`
