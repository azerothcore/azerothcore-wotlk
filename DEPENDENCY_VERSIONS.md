# AzerothCore Dependency Versions

Based on official AzerothCore requirements as of 2024.

## Windows Requirements
- **Operating System**: Windows ≥ 10
- **Visual Studio**: ≥ 2022 (v17) - Community Edition (No preview versions)
- **CMake**: ≥ 3.27
- **MySQL**: ≥ 8.0 (Recommended: 8.4)
  - ⚠️ MariaDB is NOT supported
  - MySQL 5.7 and 8.1 are NOT supported
- **Boost**: ≥ 1.78 (Recommended: 1.81.0)
- **OpenSSL**: ≥ 3.x.x

## Linux/Ubuntu Requirements
- **Operating System**: Ubuntu 22.04 LTS recommended
- **Compiler**: GCC/G++ or Clang (latest stable)
- **CMake**: ≥ 3.16
- **MySQL**: ≥ 8.0
  - ⚠️ MariaDB is NOT supported
- **Boost**: ≥ 1.74
- **OpenSSL**: ≥ 3.0.x
- **ACE**: libace-dev (latest from apt)

## macOS Requirements
- **Operating System**: macOS ≥ 11
- **Xcode**: Latest from App Store
- **CMake**: ≥ 3.16
- **MySQL**: ≥ 8.0
- **Boost**: ≥ 1.74
- **OpenSSL**: ≥ 3.0 (use openssl@3 from Homebrew)
- **Bash**: ≥ 5.0

## Important Notes

### MySQL/MariaDB
- **As of September 19, 2024**: MariaDB is no longer supported
- MySQL versions 5.7 and 8.1 are explicitly not supported
- Use MySQL 8.0 or 8.4 (recommended)

### Compiler Requirements
- **Windows**: Visual Studio 2022 with C++ workload
- **Linux**: GCC/G++ or Clang with C++20 support
- **macOS**: Xcode command line tools

### Build Configuration
All platforms should use:
- Build type: `RelWithDebInfo` or `Release`
- Scripts: `static`
- Warnings: Enabled (`WITH_WARNINGS=1`)

## CI/CD Verification

The GitHub Actions workflows are configured to use these exact versions:
- Windows CI: VS 2022, CMake 3.27, MySQL 8.4
- Ubuntu CI: Ubuntu 22.04, CMake 3.27, MySQL 8.x
- macOS CI: macOS 13, CMake 3.27, MySQL 8.0

## Local Development Setup

### Verify your versions:
```bash
# CMake
cmake --version

# MySQL
mysql --version

# OpenSSL
openssl version

# Boost (Linux/macOS)
dpkg -s libboost-dev | grep Version  # Ubuntu
brew list --version boost             # macOS

# Visual Studio (Windows)
# Check in Visual Studio Installer
```

### Required Environment Variables (Windows):
- `BOOST_ROOT` - Path to Boost installation
- Add MySQL bin directory to PATH
- Add CMake to PATH

## Troubleshooting

If builds fail due to version mismatches:
1. Update to the minimum required versions listed above
2. Clear CMake cache and rebuild from scratch
3. Ensure no MariaDB packages are installed
4. Verify MySQL 8.0+ is properly installed and accessible

## References
- [Windows Requirements](https://www.azerothcore.org/wiki/windows-requirements)
- [Linux Requirements](https://www.azerothcore.org/wiki/linux-requirements)
- [macOS Requirements](https://www.azerothcore.org/wiki/macos-requirements)