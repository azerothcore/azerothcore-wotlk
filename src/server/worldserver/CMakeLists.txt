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
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders)

if( WIN32 )
  list(APPEND PRIVATE_SOURCES ${sources_windows})
  if ( MSVC )
    list(APPEND PRIVATE_SOURCES worldserver.rc)
  endif()
endif()

if (USE_COREPCH)
  set(PRIVATE_PCH_HEADER PrecompiledHeaders/worldPCH.h)
endif()

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(worldserver
  ${PRIVATE_SOURCES})

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES
  # Exclude
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders)

target_include_directories(worldserver
  PUBLIC
    ${PUBLIC_INCLUDES}
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CMAKE_SOURCE_DIR}/src/server/game
    ${CMAKE_SOURCE_DIR}/src/server/game/Accounts
    ${CMAKE_SOURCE_DIR}/src/server/game/Achievements
    ${CMAKE_SOURCE_DIR}/src/server/game/AI
    ${CMAKE_SOURCE_DIR}/src/server/game/AI/CoreAI
    ${CMAKE_SOURCE_DIR}/src/server/game/AI/ScriptedAI
    ${CMAKE_SOURCE_DIR}/src/server/game/AI/SmartScripts
    ${CMAKE_SOURCE_DIR}/src/server/game/AuctionHouse
    ${CMAKE_SOURCE_DIR}/src/server/game/AuctionHouse/AuctionHouseBot
    ${CMAKE_SOURCE_DIR}/src/server/game/Battlefield
    ${CMAKE_SOURCE_DIR}/src/server/game/Battlefield/Zones
    ${CMAKE_SOURCE_DIR}/src/server/game/Battlegrounds
    ${CMAKE_SOURCE_DIR}/src/server/game/Battlegrounds/Zones
    ${CMAKE_SOURCE_DIR}/src/server/game/Calendar
    ${CMAKE_SOURCE_DIR}/src/server/game/Chat
    ${CMAKE_SOURCE_DIR}/src/server/game/Chat/Channels
    ${CMAKE_SOURCE_DIR}/src/server/game/Combat
    ${CMAKE_SOURCE_DIR}/src/server/game/Conditions
    ${CMAKE_SOURCE_DIR}/src/server/game/DataStores
    ${CMAKE_SOURCE_DIR}/src/server/game/DungeonFinding
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Creature
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Corpse
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/DynamicObject
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/GameObject
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Item
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Item/Container
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Object
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Object/Updates
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Pet
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Player
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Totem
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Unit
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Vehicle
    ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Transport
    ${CMAKE_SOURCE_DIR}/src/server/game/Events
    ${CMAKE_SOURCE_DIR}/src/server/game/Globals
    ${CMAKE_SOURCE_DIR}/src/server/game/Grids/Cells
    ${CMAKE_SOURCE_DIR}/src/server/game/Grids/Notifiers
    ${CMAKE_SOURCE_DIR}/src/server/game/Grids
    ${CMAKE_SOURCE_DIR}/src/server/game/Groups
    ${CMAKE_SOURCE_DIR}/src/server/game/Guilds
    ${CMAKE_SOURCE_DIR}/src/server/game/Handlers
    ${CMAKE_SOURCE_DIR}/src/server/game/Instances
    ${CMAKE_SOURCE_DIR}/src/server/game/Loot
    ${CMAKE_SOURCE_DIR}/src/server/game/Mails
    ${CMAKE_SOURCE_DIR}/src/server/game/Maps
    ${CMAKE_SOURCE_DIR}/src/server/game/Miscellaneous
    ${CMAKE_SOURCE_DIR}/src/server/game/Motd
    ${CMAKE_SOURCE_DIR}/src/server/game/Movement
    ${CMAKE_SOURCE_DIR}/src/server/game/Movement/Spline
    ${CMAKE_SOURCE_DIR}/src/server/game/Movement/MovementGenerators
    ${CMAKE_SOURCE_DIR}/src/server/game/Movement/Waypoints
    ${CMAKE_SOURCE_DIR}/src/server/game/OutdoorPvP
    ${CMAKE_SOURCE_DIR}/src/server/game/Pools
    ${CMAKE_SOURCE_DIR}/src/server/game/PrecompiledHeaders
    ${CMAKE_SOURCE_DIR}/src/server/game/Quests
    ${CMAKE_SOURCE_DIR}/src/server/game/Reputation
    ${CMAKE_SOURCE_DIR}/src/server/game/Scripting
    ${CMAKE_SOURCE_DIR}/src/server/game/Server/Protocol
    ${CMAKE_SOURCE_DIR}/src/server/game/Server
    ${CMAKE_SOURCE_DIR}/src/server/game/Skills
    ${CMAKE_SOURCE_DIR}/src/server/game/Spells
    ${CMAKE_SOURCE_DIR}/src/server/game/Spells/Auras
    ${CMAKE_SOURCE_DIR}/src/server/game/Tools
    ${CMAKE_SOURCE_DIR}/src/server/game/Warden
    ${CMAKE_SOURCE_DIR}/src/server/game/Warden/Modules
    ${CMAKE_SOURCE_DIR}/src/server/game/Weather
    ${CMAKE_SOURCE_DIR}/src/server/game/World
    ${CMAKE_SOURCE_DIR}/src/server/game/Misc
    ${CMAKE_SOURCE_DIR}/src/server/scripts/PrecompiledHeaders
    ${CMAKE_SOURCE_DIR}/src/server/authserver/Server
    ${CMAKE_SOURCE_DIR}/src/server/authserver/Realms)

if( NOT WIN32 )
  set_target_properties(worldserver PROPERTIES
    COMPILE_DEFINITIONS _TRINITY_CORE_CONFIG="${CONF_DIR}/worldserver.conf"
  )
endif()

add_dependencies(worldserver revision.h)

if( UNIX AND NOT NOJEM )
  set(worldserver_LINK_FLAGS "-pthread -lncurses ${worldserver_LINK_FLAGS}")
endif()

set_target_properties(worldserver PROPERTIES LINK_FLAGS "${worldserver_LINK_FLAGS}")

target_link_libraries(worldserver
  PUBLIC
    game
    common
    scripts
    gsoap
    readline
    ${GPERFTOOLS_LIBRARIES})

set_target_properties(worldserver
  PROPERTIES
    FOLDER
      "server")

if( WIN32 )
  if ( MSVC )
    add_custom_command(TARGET worldserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/worldserver.conf.dist ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/
    )
  elseif ( MINGW )
    add_custom_command(TARGET worldserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/worldserver.conf.dist ${CMAKE_BINARY_DIR}/bin/
    )
  endif()
endif()

if( UNIX )
  install(TARGETS worldserver DESTINATION bin)
elseif( WIN32 )
  install(TARGETS worldserver DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif()

install(FILES worldserver.conf.dist DESTINATION ${CONF_DIR})

# Generate precompiled header
if( USE_COREPCH )
  add_cxx_pch(worldserver ${PRIVATE_PCH_HEADER})
endif()

# handle config file
CU_GET_GLOBAL("MODULE_CONFIG_FILE_LIST")
FOREACH(configFile ${MODULE_CONFIG_FILE_LIST})
if( WIN32 )
  if ( MSVC )
    add_custom_command(TARGET worldserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy "${configFile}" ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/
    )
  elseif ( MINGW )
    add_custom_command(TARGET worldserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy "${configFile}" ${CMAKE_BINARY_DIR}/bin/
    )
  endif()
endif()
install(FILES "${configFile}" DESTINATION ${CONF_DIR})
ENDFOREACH()

CU_GET_GLOBAL("MODULE_CONFIG_FILE_LIST")
FOREACH(configFile ${MODULE_CONFIG_FILE_LIST})
    get_filename_component(file_name ${configFile} NAME_WE)
    set(CONFIG_LIST ${CONFIG_LIST}${file_name},)
ENDFOREACH()
add_definitions(-DCONFIG_FILE_LIST="\\"${CONFIG_LIST}\\"")
# end handle config file

CU_RUN_HOOK("AFTER_WORLDSERVER_CMAKE")
