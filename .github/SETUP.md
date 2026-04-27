# Setup Instructions

## 1) Prerequisites

- Linux or WSL2 environment
- CMake, GCC/Clang, Make, and Git
- MySQL/MariaDB
- Databases: `acore_auth`, `acore_characters`, `acore_world`

## 2) Clone Repository

```bash
git clone <your-blackrose-repo-url>
cd BlackroseWoW
```

## 3) Configure and Build

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/azeroth-server -DCMAKE_BUILD_TYPE=RelWithDebInfo \
 -DSCRIPTS=static -DMODULES=static
make -j$(nproc)
make install
```

## 4) Configure Server

- Copy generated `.dist` configs into active config files.
- Update auth/world DB connection details.
- Confirm Blackrose custom settings in `worldserver.conf`:
  - `Death.AllowCorpseReclaim = 1` (set to `0` to disable corpse reclaim)

## 5) Start Services

- Start `authserver` and `worldserver` from install output.
- Or use startup tooling in `apps/startup-scripts/` for operational management.
- Keep executable permissions on helper scripts in Linux/WSL environments.

## 6) Validate Startup

- Verify both services boot without fatal errors.
- Login with a test account and validate baseline realm behavior.
- Validate Blackrose custom rule behavior before production rollout.
