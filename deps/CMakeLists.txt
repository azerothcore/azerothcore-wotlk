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

if(CMAKE_SYSTEM_NAME MATCHES "Windows")
  if(USE_MYSQL_SOURCES)
      add_subdirectory(mysqllite)
  endif()
endif()

add_subdirectory(SFMT)
add_subdirectory(argon2)
add_subdirectory(boost)
add_subdirectory(fmt)
add_subdirectory(jemalloc)
add_subdirectory(openssl)
add_subdirectory(stdfs)
add_subdirectory(threads)

function(add_tinycbor)
  if (POLICY CMP0077)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0077 NEW)
  endif()

  set(BUILD_EXAMPLES OFF)
  set(BUILD_TESTING OFF)
  set(BUILD_TOOLS OFF)
  set(WITH_CBOR2JSON OFF)
  add_subdirectory(tinycbor EXCLUDE_FROM_ALL)

  if (POLICY CMP0077)
    cmake_policy(POP)
  endif()

  target_compile_options(tinycbor
    PRIVATE
      $<$<C_COMPILER_ID:MSVC>:/wd4244 /wd5287>
      $<$<NOT:$<C_COMPILER_ID:MSVC>>:-w>)
  set_target_properties(tinycbor
    PROPERTIES
      FOLDER
        "deps")
endfunction()

add_tinycbor()
add_subdirectory(utf8cpp)

if ((APPS_BUILD AND (NOT APPS_BUILD STREQUAL "none")) OR BUILD_TOOLS_DB_IMPORT)
  add_subdirectory(mysql)
endif()

if (BUILD_APPLICATION_WORLDSERVER OR BUILD_TOOLS_MAPS)
  add_subdirectory(zlib)
  add_subdirectory(g3dlite)
  add_subdirectory(recastnavigation)
endif()

if (BUILD_APPLICATION_WORLDSERVER)
  add_subdirectory(readline)
  add_subdirectory(gsoap)
  add_subdirectory(gperftools)
endif()

if (BUILD_TOOLS_MAPS)
  add_subdirectory(bzip2)
  add_subdirectory(libmpq)
  add_subdirectory(fkYAML)
endif()
