#
# This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

# set up output paths for executable binaries (.exe-files, and .dll-files on DLL-capable platforms)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(MSVC_EXPECTED_VERSION 19.24)
set(MSVC_EXPECTED_VERSION_STRING "Microsoft Visual Studio 2019 16.4")

if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS MSVC_EXPECTED_VERSION)
  message(FATAL_ERROR "MSVC: AzerothCore requires version ${MSVC_EXPECTED_VERSION} (${MSVC_EXPECTED_VERSION_STRING}) to build but found ${CMAKE_CXX_COMPILER_VERSION}")
else()
  message(STATUS "MSVC: Minimum version required is ${MSVC_EXPECTED_VERSION}, found ${CMAKE_CXX_COMPILER_VERSION} - ok!")
endif()

# CMake sets warning flags by default, however we manage it manually
# for different core and dependency targets
string(REGEX REPLACE "/W[0-4] " "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
# Search twice, once for space after /W argument,
# once for end of line as CMake regex has no \b
string(REGEX REPLACE "/W[0-4]$" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
string(REGEX REPLACE "/W[0-4] " "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REGEX REPLACE "/W[0-4]$" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")

# https://tinyurl.com/jxnc4s83
target_compile_options(acore-compile-option-interface
    INTERFACE
      /utf-8)

if(PLATFORM EQUAL 64)
  # This definition is necessary to work around a bug with Intellisense described
  # here: http://tinyurl.com/2cb428.  Syntax highlighting is important for proper
  # debugger functionality.
  target_compile_definitions(acore-compile-option-interface
    INTERFACE
      -D_WIN64)
  message(STATUS "MSVC: 64-bit platform, enforced -D_WIN64 parameter")

  # Enable extended object support for debug compiles on X64 (not required on X86)
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /bigobj")
  message(STATUS "MSVC: Enabled extended object-support for debug-compiles")
else()
  # mark 32 bit executables large address aware so they can use > 2GB address space
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /LARGEADDRESSAWARE")
  message(STATUS "MSVC: Enabled large address awareness")

  target_compile_options(acore-compile-option-interface
    INTERFACE
      /arch:SSE2)
  message(STATUS "MSVC: Enabled SSE2 support")
endif()

# Set build-directive (used in core to tell which buildtype we used)
# msbuild/devenv don't set CMAKE_MAKE_PROGRAM, you can choose build type from a dropdown after generating projects
if("${CMAKE_MAKE_PROGRAM}" MATCHES "MSBuild")
  target_compile_definitions(acore-compile-option-interface
    INTERFACE
      -D_BUILD_DIRECTIVE="$(ConfigurationName)")
else()
  # while all make-like generators do (nmake, ninja)
  target_compile_definitions(acore-compile-option-interface
    INTERFACE
      -D_BUILD_DIRECTIVE="${CMAKE_BUILD_TYPE}")
endif()

# multithreaded compiling on VS
target_compile_options(acore-compile-option-interface
  INTERFACE
    /MP)

# Define _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES - eliminates the warning by changing the strcpy call to strcpy_s, which prevents buffer overruns
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -D_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES)
message(STATUS "MSVC: Overloaded standard names")

# Ignore warnings about older, less secure functions
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -D_CRT_SECURE_NO_WARNINGS)
message(STATUS "MSVC: Disabled NON-SECURE warnings")

# Ignore warnings about POSIX deprecation
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -D_CRT_NONSTDC_NO_WARNINGS)
message(STATUS "MSVC: Disabled POSIX warnings")

# Ignore warnings about INTMAX_MAX
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -D__STDC_LIMIT_MACROS)
message(STATUS "MSVC: Disabled INTMAX_MAX warnings")

# Ignore specific warnings
target_compile_options(acore-compile-option-interface
  INTERFACE
    /wd4351  # C4351: new behavior: elements of array 'x' will be default initialized
    /wd4091) # C4091: 'typedef ': ignored on left of '' when no variable is declared

# Define NOMINMAX
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -DNOMINMAX)
message(STATUS "MSVC: Enable NOMINMAX")

if(NOT WITH_WARNINGS)
  target_compile_options(acore-warning-interface
    INTERFACE
      /wd4996  # C4996 deprecation
      /wd4985  # C4985 'symbol-name': attributes not present on previous declaration.
      /wd4244  # C4244 'argument' : conversion from 'type1' to 'type2', possible loss of data
      /wd4267  # C4267 'var' : conversion from 'size_t' to 'type', possible loss of data
      /wd4619  # C4619 #pragma warning : there is no warning number 'number'
      /wd4512) # C4512 'class' : assignment operator could not be generated

  message(STATUS "MSVC: Disabled generic compiletime warnings")
endif()

# Move some warnings that are enabled for other compilers from level 4 to level 3
target_compile_options(acore-compile-option-interface
  INTERFACE
    /w34100  # C4100 'identifier' : unreferenced formal parameter
    /w34101  # C4101: 'identifier' : unreferenced local variable
    /w34189  # C4189: 'identifier' : local variable is initialized but not referenced
    /w34389) # C4189: 'equality-operator' : signed/unsigned mismatch

if(BUILD_SHARED_LIBS)
  target_compile_options(acore-compile-option-interface
    INTERFACE
      /wd4251  # C4251: needs to have dll-interface to be used by clients of class '...'
      /wd4275) # C4275: non dll-interface class ...' used as base for dll-interface class '...'

  message(STATUS "MSVC: Enabled shared linking")
endif()

# Enable and treat as errors the following warnings to easily detect virtual function signature failures:
target_compile_options(acore-warning-interface
  INTERFACE
    /we4263  # 'function' : member function does not override any base class virtual member function
    /we4264) # 'virtual_function' : no override available for virtual member function from base 'class'; function is hidden

# Disable incremental linking in debug builds.
# To prevent linking getting stuck (which might be fixed in a later VS version).
macro(DisableIncrementalLinking variable)
  string(REGEX REPLACE "/INCREMENTAL *" "" ${variable} "${${variable}}")
  set(${variable} "${${variable}} /INCREMENTAL:NO")
endmacro()

DisableIncrementalLinking(CMAKE_EXE_LINKER_FLAGS_DEBUG)
DisableIncrementalLinking(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO)
DisableIncrementalLinking(CMAKE_SHARED_LINKER_FLAGS_DEBUG)
DisableIncrementalLinking(CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO)
