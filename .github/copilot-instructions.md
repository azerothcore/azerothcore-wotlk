# AzerothCore WotLK Server
AzerothCore is an open-source World of Warcraft 3.3.5a server emulator written in C++ with a sophisticated modular architecture. The project uses CMake for building, MySQL for databases, and provides comprehensive tools for development, testing, and deployment.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Initial Setup and Dependencies
- Install system dependencies: `./acore.sh install-deps`
  - **NOTE**: May fail with MySQL download errors due to network restrictions - this is normal
  - Manual fallback: `sudo apt install -y mysql-server libmysqlclient-dev cmake build-essential clang libboost-all-dev libbz2-dev libreadline6-dev libssl-dev openssl zlib1g-dev ccache`
- Start MySQL service: `sudo systemctl start mysql`
- Download client data: `./acore.sh client-data` (downloads 1.2GB in ~5 seconds)

### Build Process
- **CRITICAL**: Full build takes approximately **11 minutes**. NEVER CANCEL. Set timeout to 60+ minutes.
- Clean, configure, and compile: `./acore.sh compiler all`
  - Clean only: `./acore.sh compiler clean`
  - Configure only: `./acore.sh compiler configure` 
  - Compile only: `./acore.sh compiler compile`
- Built binaries location: `env/dist/bin/` (authserver, worldserver)
- Configuration files: `env/dist/etc/` (authserver.conf, worldserver.conf)

### Testing
- **CRITICAL**: Install BATS test framework: `sudo apt install -y bats`
- Run all tests: `apps/test-framework/run-tests.sh --all` - takes **28 seconds**, runs **103 tests**
- Run specific module tests: `apps/test-framework/run-tests.sh startup-scripts`
- Test framework options: `--verbose`, `--debug`, `--filter <pattern>`, `--count`

### Running Servers
- **Database Setup Required**: Servers will fail to start without proper MySQL database configuration
- Test binary functionality: `./env/dist/bin/authserver --version` and `./env/dist/bin/worldserver --version`
- Dry run (validates config): `./env/dist/bin/authserver --dry-run` and `./env/dist/bin/worldserver --dry-run`
- Run with restarter: `./acore.sh run-worldserver` or `./acore.sh run-authserver`
- Service management: `./acore.sh service-manager` for background services

## Validation Scenarios

### After Making Changes - ALWAYS Validate:
1. **Build Validation**: Run `./acore.sh compiler all` - ensure it completes in ~11 minutes
2. **Test Validation**: Run `apps/test-framework/run-tests.sh --all` - ensure all 103 tests pass in ~28 seconds
3. **Binary Validation**: Check that `./env/dist/bin/authserver --version` and `./env/dist/bin/worldserver --version` work
4. **Configuration Validation**: Ensure `./env/dist/bin/authserver --dry-run` and `./env/dist/bin/worldserver --dry-run` start correctly (will fail on DB connection without proper setup)

### Complete Development Workflow Test:
1. Make code changes in `src/` directory
2. Run `./acore.sh compiler compile` (faster than full rebuild)
3. Run relevant tests: `apps/test-framework/run-tests.sh --filter <your-feature>`
4. Test server startup with dry-run mode
5. For module changes, test module system: `./acore.sh module --help`

## Timing Expectations - NEVER CANCEL

- **Build (./acore.sh compiler all)**: 11 minutes - NEVER CANCEL, set 60+ minute timeout
- **Test suite (all tests)**: 28 seconds, runs 103 tests
- **Individual test module**: 13 seconds for startup-scripts (27 tests)
- **Client data download**: ~5 seconds for 1.2GB
- **Configure only**: ~30 seconds
- **Compile only (after configure)**: ~10 minutes
- **Clean**: ~5 seconds

## Module Management
- List available commands: `./acore.sh module --help`
- Module syntax: `name`, `owner/name`, `name:branch`, `name:dirname@branch`, or full GitHub URLs
- Install modules: `./acore.sh module install <module-spec>`
- Update modules: `./acore.sh module update --all`
- Remove modules: `./acore.sh module remove <module-name>`
- List installed: `./acore.sh module list`

## Docker Support
- Docker commands available: `./acore.sh docker --help`
- Development server: `./acore.sh docker dev:up`
- Production build: `./acore.sh docker prod:build`
- **NOTE**: Docker available at `/usr/bin/docker` version 28.0.4

## Common Commands Reference

### Repository Status
- Version: `./acore.sh version` → "AzerothCore Rev. 14.0.0-dev"
- Repository update: `./acore.sh pull`
- Reset repository: `./acore.sh reset`

### Build System Details
- Build system: CMake 3.31.6 with Clang 18.1.3 (default compiler)
- GCC 13.3.0 also available
- Source root: `/home/runner/work/azerothcore-wotlk/azerothcore-wotlk`
- Build directory: `var/build/obj/`
- Install directory: `env/dist/`
- Configuration: `conf/dist/config.sh` (copy to `conf/config.sh` for customization)

### Key Directories
```
├── src/                    # C++ source code
├── apps/                   # Tools and utilities
│   ├── compiler/          # Build system scripts
│   ├── installer/         # Installation utilities  
│   ├── startup-scripts/   # Server management scripts
│   ├── test-framework/    # BATS testing framework
│   └── docker/           # Docker configurations
├── env/dist/             # Built binaries and configs
│   ├── bin/              # authserver, worldserver executables
│   ├── etc/              # Configuration files
│   └── logs/             # Runtime logs
├── modules/              # Module installation directory
├── conf/                 # Build configuration
└── .github/              # CI/CD workflows
```

### CI/CD and Code Quality
- All builds run in GitHub Actions with multiple compiler combinations
- Workflows: `core-build-nopch.yml`, `core-build-pch.yml`, `docker_build.yml`, etc.
- Code style validation available
- Build requires clean startup with no errors in `env/dist/logs/Errors.log`

## Important Notes

### Build Requirements
- **Ubuntu 24.04** (tested platform)
- **MySQL 8.0+** for database operations
- **C++20** standard (automatically enabled)
- **Boost 1.83.0** for dependencies
- **CMake 3.16+** minimum version

### Development Best Practices
- Always use `./acore.sh` dashboard for consistent operations
- Build with optimizations: Release mode (default)
- Use ccache for faster incremental builds (available but disabled by default)
- Test early and often with the BATS framework
- Module development follows specific patterns in `modules/` directory

### Network and Data Requirements
- Client data: **1.2GB download** (automated via `./acore.sh client-data`)
- Database setup required for server operation
- Firewall restrictions may affect dependency downloads

### Troubleshooting
- **Build fails**: Check `var/build/obj/` for CMake errors
- **Server won't start**: Check `env/dist/logs/` for error details
- **Database issues**: Verify MySQL service and connection settings in `env/dist/etc/*.conf`
- **Module issues**: Check module compatibility and installation logs
- **Tests failing**: Ensure BATS is installed and all dependencies are met

This codebase is mature, well-tested, and follows established patterns. The build system is reliable but requires patience due to the large C++ codebase size.