# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

file(GLOB sources libmpq/*.c libmpq/*.h)

add_library(mpq STATIC ${sources})

set_target_properties(mpq PROPERTIES LINKER_LANGUAGE CXX)

if(WIN32)
  set(WIN_EXTRA_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR}/win)
endif()

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

target_include_directories(mpq
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${WIN_EXTRA_INCLUDE}
    ${CMAKE_SOURCE_DIR}/deps/zlib
    ${CMAKE_SOURCE_DIR}/deps/bzip2)

target_link_libraries(mpq
  PRIVATE
    acore-dependency-interface
  PUBLIC
    zlib
    bzip2)

set_target_properties(mpq
  PROPERTIES
    FOLDER
      "deps")