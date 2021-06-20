#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

########### authserver ###############

CollectSourceFiles(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE_SOURCES
  # Exclude
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders)

if( WIN32 )
  list(APPEND PRIVATE_SOURCES ${winDebugging})
  if ( MSVC )
    list(APPEND PRIVATE_SOURCES authserver.rc)
  endif()
endif()

if (USE_COREPCH)
  set(PRIVATE_PCH_HEADER PrecompiledHeaders/authPCH.h)
endif()

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(authserver
  ${PRIVATE_SOURCES})

add_dependencies(authserver revision.h)

if(NOT WIN32)
  set_target_properties(authserver PROPERTIES
    COMPILE_DEFINITIONS _ACORE_REALM_CONFIG="${CONF_DIR}/authserver.conf")
endif()

target_link_libraries(authserver
  PUBLIC
    shared)

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES
  # Exclude
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders)

target_include_directories(authserver
  PUBLIC
    ${PUBLIC_INCLUDES}
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

set_target_properties(authserver
  PROPERTIES
    FOLDER
      "server")

if( WIN32 )
  if ( MSVC )
    add_custom_command(TARGET authserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/authserver.conf.dist ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/
    )
  elseif ( MINGW )
    add_custom_command(TARGET authserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/authserver.conf.dist ${CMAKE_BINARY_DIR}/bin/
    )
  endif()
endif()

if( UNIX )
  install(TARGETS authserver DESTINATION bin)
elseif( WIN32 )
  install(TARGETS authserver DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif()

install(FILES  authserver.conf.dist DESTINATION ${CONF_DIR})

# Generate precompiled header
if (USE_COREPCH)
  add_cxx_pch(authserver ${PRIVATE_PCH_HEADER})
endif()

CU_RUN_HOOK("AFTER_AUTHSERVER_CMAKE")
