#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
# Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

include(CheckSymbolExists)

set(strtod_l_headers stdlib.h)

if(WIN32)
  check_symbol_exists(open io.h HAVE_OPEN)
  check_symbol_exists(_strtod_l "${strtod_l_headers}" HAVE_STRTOD_L)
else()
  check_symbol_exists(open fcntl.h HAVE_OPEN)
  check_symbol_exists(strtod_l "${strtod_l_headers}" HAVE_STRTOD_L)
endif()

function(add_headers VAR)
  set(headers ${${VAR}})
  foreach (header ${ARGN})
    set(headers ${headers} fmt/${header})
  endforeach()
  set(${VAR} ${headers} PARENT_SCOPE)
endfunction()

# Define the fmt library, its includes and the needed defines.
add_headers(FMT_HEADERS 
  chrono.h 
  color.h 
  compile.h 
  core.h 
  format.h 
  format-inl.h
  locale.h 
  ostream.h 
  printf.h 
  ranges.h
  safe-duration-cast.h)

set(FMT_SOURCES fmt/format.cc)

if(HAVE_OPEN)
  add_headers(FMT_HEADERS posix.h)
  set(FMT_SOURCES ${FMT_SOURCES} fmt/posix.cc)
endif()

add_library(fmt STATIC 
  ${FMT_SOURCES}
  ${FMT_HEADERS})

GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

if (HAVE_STRTOD_L)
  target_compile_definitions(fmt 
    PUBLIC 
      FMT_LOCALE)
endif()

target_include_directories(fmt
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(fmt
  PRIVATE
    acore-dependency-interface)

set_target_properties(fmt
  PROPERTIES
    FOLDER
      "deps")
