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

# check what platform we're on (64-bit or 32-bit), and create a simpler test than CMAKE_SIZEOF_VOID_P
if(CMAKE_SIZEOF_VOID_P MATCHES 8)
    set(PLATFORM 64)
    MESSAGE(STATUS "Detected 64-bit platform")
else()
    set(PLATFORM 32)
    MESSAGE(STATUS "Detected 32-bit platform")
endif()

include("${CMAKE_SOURCE_DIR}/src/cmake/platform/settings.cmake")

if(CMAKE_SYSTEM_PROCESSOR MATCHES "amd64|x86_64|AMD64")
  set(ACORE_SYSTEM_PROCESSOR "amd64")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm|ARM|aarch|AARCH)64$")
  set(ACORE_SYSTEM_PROCESSOR "arm64")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm|ARM|aarch|AARCH)$")
  set(ACORE_SYSTEM_PROCESSOR "arm")
else()
  set(ACORE_SYSTEM_PROCESSOR "x86")
endif()

# detect MSVC special case of using cmake -A switch (which doesn't set any cross compiling variables)

if(CMAKE_GENERATOR_PLATFORM STREQUAL "Win32")
  set(ACORE_SYSTEM_PROCESSOR "x86")
elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
  set(ACORE_SYSTEM_PROCESSOR "amd64")
elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "ARM")
  set(ACORE_SYSTEM_PROCESSOR "arm")
elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "ARM64")
  set(ACORE_SYSTEM_PROCESSOR "arm64")
endif()

message(STATUS "Detected ${ACORE_SYSTEM_PROCESSOR} processor architecture")

if(WIN32)
  include("${CMAKE_SOURCE_DIR}/src/cmake/platform/win/settings.cmake")
elseif(UNIX)
  include("${CMAKE_SOURCE_DIR}/src/cmake/platform/unix/settings.cmake")
endif()

include("${CMAKE_SOURCE_DIR}/src/cmake/platform/after_platform.cmake")
