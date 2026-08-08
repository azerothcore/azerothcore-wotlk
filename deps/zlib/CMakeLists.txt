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

# some Win32 builds of deps that might be needed for other modules will include
# their own vendored zlib, Node.js being the initial example. to avoid linker
# conflicts, let them override ours by setting these globals.
CU_GET_GLOBAL(ZLIB_EXTERNAL_INCLUDE_DIR)
CU_GET_GLOBAL(ZLIB_EXTERNAL_IMPLIB)
if(ZLIB_EXTERNAL_INCLUDE_DIR AND ZLIB_EXTERNAL_IMPLIB)
  add_library(zlib SHARED IMPORTED GLOBAL)

  set_target_properties(zlib
    PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES
        "${ZLIB_EXTERNAL_INCLUDE_DIR}"
      IMPORTED_IMPLIB
        "${ZLIB_EXTERNAL_IMPLIB}")

  set(ZLIB_FOUND ON PARENT_SCOPE)
  return()
endif()

if(UNIX)
  # Look for an installed zlib on unix, and require it to exist
  find_package(ZLIB REQUIRED)
else()
  # Also look for installed zlib on other platforms, but we can fall back.
  find_package(ZLIB)
endif()

set(ZLIB_FOUND ${ZLIB_FOUND} PARENT_SCOPE)
if(ZLIB_FOUND)
  add_library(zlib SHARED IMPORTED GLOBAL)

  set_target_properties(zlib
    PROPERTIES
      IMPORTED_LOCATION
        "${ZLIB_LIBRARIES}"
      INTERFACE_INCLUDE_DIRECTORIES
        "${ZLIB_INCLUDE_DIRS}")
else()
  # Use the bundled source on windows
  SET(zlib_STAT_SRCS
    adler32.c
    compress.c
    crc32.c
    deflate.c
    infback.c
    inffast.c
    inflate.c
    inftrees.c
    trees.c
    uncompr.c
    zutil.c
  )

  add_library(zlib STATIC
    ${zlib_STAT_SRCS})

  set_target_properties(zlib PROPERTIES LINKER_LANGUAGE CXX)

  target_include_directories(zlib
    PUBLIC
      ${CMAKE_CURRENT_SOURCE_DIR})

  target_link_libraries(zlib
    PRIVATE
      acore-dependency-interface)

  set_target_properties(zlib
      PROPERTIES
        FOLDER
          "deps")
endif()
