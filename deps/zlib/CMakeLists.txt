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

if(UNIX)
  # Look for an installed zlib on unix
  find_package(ZLIB REQUIRED)

  add_library(zlib SHARED IMPORTED GLOBAL)

  set_target_properties(zlib
    PROPERTIES
      IMPORTED_LOCATION
        "${ZLIB_LIBRARIES}"
      INTERFACE_INCLUDE_DIRECTORIES
        "${ZLIB_INCLUDE_DIRS}")
elseif(WIN32 AND ZLIB_IMPORT)
  # libnode.dll exports the zlib C API. Make the core's zlib target an IMPORTED
  # shared library bound to libnode.dll so there's no duplicate symbol at link
  # time. ZLIB_IMPORT is a thin import lib (generated from a
  # .def of libnode.dll's zlib exports) that the linker uses instead of the
  # bundled static zlib.
  add_library(zlib SHARED IMPORTED GLOBAL)
  set_target_properties(zlib
    PROPERTIES
      IMPORTED_IMPLIB
        "${ZLIB_IMPORT}"
      INTERFACE_INCLUDE_DIRECTORIES
        "${CMAKE_CURRENT_SOURCE_DIR}")
  set_target_properties(zlib PROPERTIES FOLDER "deps")
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
