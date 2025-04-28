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

CollectSourceFiles(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE_SOURCES)

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_library(shared
  ${PRIVATE_SOURCES})

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES)

target_include_directories(shared
  PUBLIC
    ${PUBLIC_INCLUDES}
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(shared
  PRIVATE
    acore-core-interface
  PUBLIC
    database)

set(ACORE_WITH_SYSTEMD OFF)
find_library(WITH_SYSTEMD systemd)
if(WITH_SYSTEMD)
  message("*** Building with SYSTEMD support")
  set(ACORE_WITH_SYSTEMD ON)
  target_link_libraries(shared PUBLIC systemd)
else(LINUX)
  message("*** Skipping SYSTEMD support")
endif (WITH_SYSTEMD)

configure_file(
  "${CMAKE_SOURCE_DIR}/src/cmake/systemd.h.in.cmake"
  "${BUILDDIR}/systemd.h"
)

set_target_properties(shared
  PROPERTIES
    FOLDER
      "server")
