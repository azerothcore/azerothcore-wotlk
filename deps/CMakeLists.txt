# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

if( MSVC )
  string(REGEX REPLACE "/W[0-4] " "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
  string(REGEX REPLACE "/W[0-4] " "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
  add_definitions(/W0)
else()
  add_definitions(-w)
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Windows")
  if(USE_MYSQL_SOURCES)
      add_subdirectory(mysqllite)
  endif()
endif()

add_subdirectory(threads)
add_subdirectory(acelite)

if(SERVERS OR TOOLS)
  add_subdirectory(zlib)
  add_subdirectory(g3dlite)
  add_subdirectory(recastnavigation)
  add_subdirectory(SFMT)
  add_subdirectory(utf8cpp)
  add_subdirectory(openssl)
endif()

if(SERVERS)
  add_subdirectory(mysql)
  add_subdirectory(readline)
  add_subdirectory(jemalloc)
  add_subdirectory(gsoap)
endif()

if(TOOLS)
  add_subdirectory(bzip2)
  add_subdirectory(libmpq)
endif()
