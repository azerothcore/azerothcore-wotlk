# StormLib

This is official repository for the StormLib library, an open-source project that can work with Blizzard MPQ archives.

## Installation and basic usage

### Windows (Visual Studio 2022)
0. Make sure you have the toolset for Visual Studio 2017 - Windows XP installed
1. Download the latest release of StormLib
2. Open the solution file `StormLib.sln` in Visual Studio 2017/2019/2022
3. Choose "Build / Batch Build" and select every build of "StormLib"
4. Choose "Rebuild"
5. The result libraries are in `.\bin\Win32` and `.\bin\x64`

Note that you can also build the library using newer toolset, such as v143. To do that, you need to retarget the projects. Right-click on the solution, then choose "Retarget solution" and pick your desired toolset version. 

### Windows (Visual Studio 2008)
1. Download the latest release of StormLib
2. Open the solution file `StormLib_vs08.sln` in Visual Studio 2008
3. Choose "Build / Batch Build" and select every build of "StormLib"
4. Choose "Rebuild"
5. The result libraries are in `.\bin\Win32` and `.\bin\x64`

### Windows (any Visual Studio version with CMake)
You can open the appropriate Visual Studio cmd prompt or launch regular cmd and load the necessary environment as specified below.  
Change your VS version as needed.

amd64
```
"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Auxiliary/Build/vcvarsall.bat" x64
cmake -G "Visual Studio 17 2022" -B build_amd64 -D BUILD_SHARED_LIBS=ON
cmake --build build --config Release
```

x86
``` 
"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Auxiliary/Build/vcvarsall.bat" x86
cmake -G "Visual Studio 17 2022" -B build_x86 -D BUILD_SHARED_LIBS=ON
```

### Windows (Test Project)
1. Include the main StormLib header: `#include <StormLib.h>`
2. Set the correct library directory for StormLibXYZ.lib:
   * X: D = Debug, R = Release
   * Y: A = ANSI build, U = Unicode build
   * Z: S = Using static CRT library, D = Using Dynamic CRT library
3. Rebuild

### Linux
```
git clone https://github.com/ladislav-zezula/StormLib.git
cd StormLib && git checkout <latest-release-tag>
cmake -B build -D BUILD_SHARED_LIBS=ON
cmake --build build --config Release
sudo cmake --install build
```

Include StormLib in your project: `#include <StormLib.h>`  
Make sure you compile your project with `-lstorm -lz -lbz2`

To produce deb/rpm packages:
```
cd build
cpack -G "DEB" -D CPACK_PACKAGE_FILE_NAME=libstorm-dev_v9.30_amd64
cpack -G "RPM" -D CPACK_PACKAGE_FILE_NAME=libstorm-devel-v9.30.x86_64
``` 

### Any platform (Conan)

[Conan](https://conan.io) can automatically resolve and build all dependencies (zlib, bzip2, libtommath) on any platform.

```
conan install . -of build -s build_type=Release --build=missing
cmake -B build -DCMAKE_BUILD_TYPE=Release -DSTORM_USE_BUNDLED_LIBRARIES=OFF -DWITH_BUNDLED_LIBTOMCRYPT=ON -DCMAKE_TOOLCHAIN_FILE=build/conan_toolchain.cmake
cmake --build build --config Release
```

`-DWITH_BUNDLED_LIBTOMCRYPT=ON` is required because `libtomcrypt` is not yet packaged in Conan Index.  

For a 32-bit build on Windows, add `-s:h arch=x86` to the `conan install` command.

### List of all CMake options

| Option Name                   | Description                                                       | Default |
|-------------------------------|-------------------------------------------------------------------|---------|
| `BUILD_SHARED_LIBS`           | Compile shared libraries                                          | OFF     |
| `STORM_UNICODE`               | Unicode or ANSI support                                           | OFF     |
| `STORM_SKIP_INSTALL`          | Skip installing files                                             | OFF     |
| `STORM_USE_BUNDLED_LIBRARIES` | Force use of bundled dependencies instead of system libraries     | OFF     |
| `WITH_BUNDLED_LIBTOMMATH`     | Bundle libtommath even when `STORM_USE_BUNDLED_LIBRARIES` is OFF  | OFF     |
| `WITH_BUNDLED_LIBTOMCRYPT`    | Bundle libtomcrypt even when `STORM_USE_BUNDLED_LIBRARIES` is OFF | OFF     |
| `STORM_BUILD_TESTS`           | Compile StormLib test application                                 | OFF     |
| `STORMTEST_USE_OLD_PATHS`     | Uses hardcoded paths for test files, OFF uses `build_folder/work` | ON      |
