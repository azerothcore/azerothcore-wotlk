#
# Copyright (C) 2010 - 2014 Eluna Lua Engine <http://emudevs.com/>
# This program is free software licensed under GPL version 3
# Please see the included DOCS/LICENSE.md for more information
#

CollectSourceFiles(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE_SOURCES
  # Exclude
  ${CMAKE_CURRENT_SOURCE_DIR}/Debugging
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders)

list(REMOVE_ITEM PRIVATE_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/lua.c)
list(REMOVE_ITEM PRIVATE_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/luac.c)

add_library(lualib STATIC
  ${PRIVATE_SOURCES})

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES)

target_include_directories(lualib
  PUBLIC
    ${PUBLIC_INCLUDES}
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

if (APPLE)
  target_compile_definitions(lualib PUBLIC LUA_USE_MACOSX)
elseif (UNIX)
  target_compile_definitions(lualib PUBLIC LUA_USE_LINUX)
endif()
