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

# Enforce compileparameters for corebuilds under GCC
# This to stop a few silly crashes that could have been avoided IF people
# weren't doing some -O3 psychooptimizations etc.

# Specified files for Windows
if (WIN32)
  # Crash logs
  set(winDebugging
    ${CMAKE_SOURCE_DIR}/src/common/Debugging/WheatyExceptionReport.cpp
    ${CMAKE_SOURCE_DIR}/src/common/Debugging/WheatyExceptionReport.h)

  # Service
  set(winService
    ${CMAKE_SOURCE_DIR}/src/common/Platform/ServiceWin32.cpp
    ${CMAKE_SOURCE_DIR}/src/common/Platform/ServiceWin32.h)
endif()

if(CMAKE_COMPILER_IS_GNUCXX AND NOT MINGW)
  add_definitions(-fno-delete-null-pointer-checks)
endif()

add_subdirectory(genrev)
add_subdirectory(server)

if (TOOLS_BUILD AND NOT TOOLS_BUILD STREQUAL "none")
  add_subdirectory(tools)
endif()

# Voice Chat server and handlers
if(BUILD_VOICECHAT)
  set(LOCAL_VOICECHAT_DIR "${CMAKE_SOURCE_DIR}/voicechat-server")

  if(EXISTS "${LOCAL_VOICECHAT_DIR}/CMakeLists.txt")
    message(STATUS "Using local voicechat-server directory: ${LOCAL_VOICECHAT_DIR}")
    add_subdirectory(${LOCAL_VOICECHAT_DIR} ${CMAKE_BINARY_DIR}/voicechat-server-build)
  else()
    include(FetchContent)

    FetchContent_Declare(
      voicechat-server
      GIT_REPOSITORY "https://github.com/azerothcore/voicechat-server.git"
      GIT_TAG "main"
    )

    message(STATUS "Fetching VoiceChat server...")
    FetchContent_MakeAvailable(voicechat-server)
  endif()
else()
  if(EXISTS ${CMAKE_SOURCE_DIR}/voicechat-server AND NOT IS_DIRECTORY ${CMAKE_SOURCE_DIR}/voicechat-server/.git)
    file(REMOVE_RECURSE ${CMAKE_SOURCE_DIR}/voicechat-server)
  endif()
endif()
