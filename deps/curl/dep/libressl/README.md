![LibreSSL image](https://www.libressl.org/images/libressl.jpg)

## Official portable version of [LibreSSL](https://www.libressl.org)

[![Linux Build Status](https://github.com/libressl/portable/actions/workflows/linux.yml/badge.svg)](https://github.com/libressl/portable/actions/workflows/linux.yml)
[![macOS Build Status](https://github.com/libressl/portable/actions/workflows/macos.yml/badge.svg)](https://github.com/libressl/portable/actions/workflows/macos.yml)
[![Windows Build Status](https://github.com/libressl/portable/actions/workflows/windows.yml/badge.svg)](https://github.com/libressl/portable/actions/workflows/windows.yml)
[![Android Build Status](https://github.com/libressl/portable/actions/workflows/android.yml/badge.svg)](https://github.com/libressl/portable/actions/workflows/android.yml)
[![Solaris Build Status](https://github.com/libressl/portable/actions/workflows/solaris.yml/badge.svg)](https://github.com/libressl/portable/actions/workflows/solaris.yml)
[![Fuzzing Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/libressl.svg)](https://bugs.chromium.org/p/oss-fuzz/issues/list?sort=-opened&can=1&q=proj:libressl)

LibreSSL is a fork of [OpenSSL](https://www.openssl.org) 1.0.1g developed by the
[OpenBSD](https://www.openbsd.org) project.  Our goal is to modernize the codebase,
improve security, and apply best practice development processes from OpenBSD.

## Compatibility with OpenSSL

LibreSSL provides much of the OpenSSL 1.1 API. The OpenSSL 3 API is not currently
supported. Incompatibilities between the projects exist and are unavoidable since
both evolve with different goals and priorities. Important incompatibilities will
be addressed if possible and as long as they are not too detrimental to LibreSSL's
goals of simplicity, security and sanity. We do not add new features, ciphers and
API without a solid reason and require that new code be clean and of high quality.

LibreSSL is not ABI compatible with any release of OpenSSL, or necessarily
earlier releases of LibreSSL. You will need to relink your programs to
LibreSSL in order to use it, just as in moving between major versions of OpenSSL.
LibreSSL's installed library version numbers are incremented to account for
ABI and API changes.

## Compatibility with other operating systems

While primarily developed on and taking advantage of APIs available on OpenBSD,
the LibreSSL portable project attempts to provide working alternatives for
other operating systems, and assists with improving OS-native implementations
where possible.

At the time of this writing, LibreSSL is known to build and work on:

* Linux (kernel 3.17 or later recommended)
* FreeBSD (tested with 9.2 and later)
* NetBSD (7.0 or later recommended)
* HP-UX (11i)
* Solaris 11 and later
* Mac OS X (tested with 10.8 and later)
* AIX (5.3 and later)
* Emscripten (3.1.44 and later)

LibreSSL also supports the following Windows environments:

* Microsoft Windows (Windows 7 / Windows Server 2008r2 or later, x86 and x64)
* Wine (32-bit and 64-bit)
* MinGW-w64, Cygwin, and Visual Studio

Official release tarballs are available at your friendly neighborhood
OpenBSD mirror in directory
[LibreSSL](https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/),
although we suggest that you use a [mirror](https://www.openbsd.org/ftp.html).

The LibreSSL portable build framework is also
[mirrored](https://github.com/libressl/portable) on GitHub.

Please report bugs either to the public libressl@openbsd.org mailing list,
or to the GitHub
[issue tracker](https://github.com/libressl/portable/issues)

Severe vulnerabilities or bugs requiring coordination with OpenSSL can be
sent to the core team at libressl-security@openbsd.org.

# Building LibreSSL

## Building from a Git checkout

If you have checked out this source using Git, or have downloaded a source 
tarball from GitHub, follow these initial steps to prepare the source tree for
building. _Note: Your build will fail if you do not follow these instructions!
If you cannot follow these instructions or cannot meet these prerequisites, 
please download an official release distribution from 
https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/ instead. Using official
releases is strongly advised if you are not a developer._

1. Ensure that you have a bash shell. This is also required on Windows.
2. Ensure that you have the following packages installed:
   automake, autoconf, git, libtool, perl.
3. Run `./autogen.sh` to prepare the source tree for building.

## Build steps using configure

Once you have the source tree prepared, run these commands to build and install:

```sh
./configure   # see ./configure --help for configuration options
make check    # runs builtin unit tests
make install  # set DESTDIR= to install to an alternate location
```

Alternatively, it is possible to run `./dist.sh` to prepare a tarball.

## Build steps using CMake

Once you have the source tree prepared, run these commands to build and install:

```sh
mkdir build
cd build
cmake ..
make
make test
```

For faster builds, you can use Ninja:

```sh
mkdir build-ninja
cd build-ninja
cmake -G"Ninja" ..
ninja
ninja test
```

Or another supported build system like Visual Studio:

```sh
mkdir build-vs2022
cd build-vs2022
cmake -G"Visual Studio 17 2022" ..
```

#### Additional CMake Options

| Option Name             | Default | Description                                                                                                     |
|-------------------------|--------:|-----------------------------------------------------------------------------------------------------------------|
| `LIBRESSL_SKIP_INSTALL` |   `OFF` | allows skipping install() rules.  Can be specified from command line using <br>```-DLIBRESSL_SKIP_INSTALL=ON``` |
| `LIBRESSL_APPS`         |    `ON` | allows skipping application builds. Apps are required to run tests                                              |
| `LIBRESSL_TESTS`        |    `ON` | allows skipping of tests. Tests are only available in static builds                                             |
| `BUILD_SHARED_LIBS`     |   `OFF` | CMake option for building shared libraries.                                                                     |
| `ENABLE_ASM`            |    `ON` | builds assembly optimized rules.                                                                                |
| `ENABLE_EXTRATESTS`     |   `OFF` | Enable extra tests that may be unreliable on some platforms                                                     |
| `ENABLE_NC`             |   `OFF` | Enable installing TLS-enabled nc(1)                                                                             |
| `OPENSSLDIR`            |   Blank | Set the default openssl directory.  Can be specified from command line using <br>```-DOPENSSLDIR=<dirname>```   |

## Build information for specific systems

### HP-UX (11i)

Set the UNIX_STD environment variable to `2003` before running `configure`
in order to build with the HP C/aC++ compiler. See the "standards(5)" man
page for more details.

```sh
export UNIX_STD=2003
./configure
make
```

### MinGW-w64 - Windows

LibreSSL builds against relatively recent versions of [MinGW-w64](https://www.mingw-w64.org/), not to be
confused with the original mingw.org project. MinGW-w64 3.2 or later
should work. See [README.mingw.md](README.mingw.md) for more information.

### Emscripten

When configuring LibreSSL for use with Emscripten, make sure to prepend
`emcmake` to your `cmake` configuration command. Once configured, you can
proceed with your usual `cmake` commands. For example:

```sh
emcmake cmake . -Bbuild
cmake --build build --config Release
ctest --test-dir build -C Release --output-on-failure
```

# Using LibreSSL

## CMake

Make a new folder in your project root (where your main `CMakeLists.txt` file is
located) called CMake. Copy the `FindLibreSSL.cmake` file to that folder, and
add the following line to your main `CMakeLists.txt`:

```cmake
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake;${CMAKE_MODULE_PATH}")
```

After your `add_executable` or `add_library` line in your `CMakeLists.txt` file
add the following:

```cmake
find_package(LibreSSL REQUIRED)
```

It will tell CMake to find LibreSSL and if found will let you use the following
3 interfaces in your `CMakeLists.txt` file:

* LibreSSL::Crypto
* LibreSSL::SSL
* LibreSSL::TLS

If you for example want to use the LibreSSL TLS library in your test program,
include it like so (SSL and Crypto are required by TLS and included
automatically too):

```cmake
target_link_libraries(test LibreSSL::TLS)
```

Full example:

```cmake
cmake_minimum_required(VERSION 3.10.0)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake;${CMAKE_MODULE_PATH}")

project(test)

add_executable(test Main.cpp)

find_package(LibreSSL REQUIRED)

target_link_libraries(test LibreSSL::TLS)
```

#### Linux

Following the guide in the sections above to compile LibreSSL using make and
running `sudo make install` will install LibreSSL to the `/usr/local/` folder,
and will be found automatically by find_package. If your system installs it to
another location, or you have placed them yourself in a different location, you
can set the CMake variable `LIBRESSL_ROOT_DIR` to the correct path, to help
CMake find the library.

#### Windows

Placing the library files in `C:/Program Files/LibreSSL/lib` and the include
files in `C:/Program Files/LibreSSL/include` should let CMake find them
automatically, but it is recommended that you use CMake-GUI to set the paths.
It is more convenient as you can have the files in any folder you choose.
