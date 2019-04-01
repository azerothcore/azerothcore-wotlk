# Copyright (C)
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

CollectSourceFiles(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE_SOURCES
  # Exclude
  ${CMAKE_CURRENT_SOURCE_DIR}/Debugging
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders)

# Manually set sources for Debugging directory as we don't want to include WheatyExceptionReport in shared project
# It needs to be included both in authserver and worldserver for the static global variable to be properly initialized
# and to handle crash logs on windows
list(APPEND PRIVATE_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/Debugging/Errors.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/Debugging/Errors.h)

if (USE_COREPCH)
  set(PRIVATE_PCH_HEADER PrecompiledHeaders/sharedPCH.h)
endif()

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_library(shared
  ${PRIVATE_SOURCES}
)

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES
  # Exclude
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders)

target_include_directories(shared
  PUBLIC
    # Provide the binary dir for all child targets
    ${CMAKE_BINARY_DIR}
    ${PUBLIC_INCLUDES}
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(shared
  PRIVATE
    game-interface
  PUBLIC
    ace
    mysql
    g3dlib
    Detour
    sfmt
    utf8cpp
    openssl
    threads
    jemalloc)

set_target_properties(shared
  PROPERTIES
    FOLDER
      "server")

# Generate precompiled header
if (USE_COREPCH)
  add_cxx_pch(shared ${PRIVATE_PCH_HEADER})
endif ()
