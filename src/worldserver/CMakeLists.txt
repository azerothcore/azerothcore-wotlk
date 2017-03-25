# Copyright (C)
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

file(GLOB_RECURSE sources_CommandLine CommandLine/*.cpp CommandLine/*.h)
file(GLOB_RECURSE sources_RemoteAccess RemoteAccess/*.cpp RemoteAccess/*.h)
file(GLOB_RECURSE sources_TCSoap TCSoap/*.cpp TCSoap/*.h)
file(GLOB_RECURSE sources_WorldThread WorldThread/*.cpp WorldThread/*.h)
file(GLOB sources_localdir *.cpp *.h)

if (USE_COREPCH)
  set(worldserver_PCH_HDR PrecompiledHeaders/worldPCH.h)
  set(worldserver_PCH_SRC PrecompiledHeaders/worldPCH.cpp)
endif()

set(worldserver_SRCS
  ${worldserver_SRCS}
  ${sources_CommandLine}
  ${sources_RemoteAccess}
  ${sources_TCSoap}
  ${sources_WorldThread}
  ${sources_localdir}
)

if( WIN32 )
  set(worldserver_SRCS
    ${worldserver_SRCS}
    ${sources_windows_Debugging}
  )
  if ( MSVC )
    set(worldserver_SRCS
      ${worldserver_SRCS}
      worldserver.rc
    )
  endif()
endif()

include_directories(
  ${CMAKE_BINARY_DIR}
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/g3dlite/include
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/recastnavigation/Detour
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/gsoap
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/sockets/include
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/SFMT
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Management
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Models
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Configuration
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Cryptography
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Cryptography/Authentication
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Database
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/DataStores
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Debugging
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Dynamic/LinkedReference
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Dynamic
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Logging
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Packets
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Threading
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Utilities
  ${CMAKE_SOURCE_DIR}/modules/acore/game-framework/src/Addons
  ${game_INCLUDE_DIRS}
  ${CMAKE_SOURCE_DIR}/src/game
  ${CMAKE_SOURCE_DIR}/src/game/Accounts
  ${CMAKE_SOURCE_DIR}/src/game/Achievements
  ${CMAKE_SOURCE_DIR}/src/game/AI
  ${CMAKE_SOURCE_DIR}/src/game/AI/CoreAI
  ${CMAKE_SOURCE_DIR}/src/game/AI/ScriptedAI
  ${CMAKE_SOURCE_DIR}/src/game/AI/SmartScripts
  ${CMAKE_SOURCE_DIR}/src/game/AuctionHouse
  ${CMAKE_SOURCE_DIR}/src/game/AuctionHouse/AuctionHouseBot
  ${CMAKE_SOURCE_DIR}/src/game/Battlefield
  ${CMAKE_SOURCE_DIR}/src/game/Battlefield/Zones
  ${CMAKE_SOURCE_DIR}/src/game/Battlegrounds
  ${CMAKE_SOURCE_DIR}/src/game/Battlegrounds/Zones
  ${CMAKE_SOURCE_DIR}/src/game/Calendar
  ${CMAKE_SOURCE_DIR}/src/game/Chat
  ${CMAKE_SOURCE_DIR}/src/game/Chat/Channels
  ${CMAKE_SOURCE_DIR}/src/game/Combat
  ${CMAKE_SOURCE_DIR}/src/game/Conditions
  ${CMAKE_SOURCE_DIR}/src/game/DataStores
  ${CMAKE_SOURCE_DIR}/src/game/DungeonFinding
  ${CMAKE_SOURCE_DIR}/src/game/Entities
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Creature
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Corpse
  ${CMAKE_SOURCE_DIR}/src/game/Entities/DynamicObject
  ${CMAKE_SOURCE_DIR}/src/game/Entities/GameObject
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Item
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Item/Container
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Object
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Object/Updates
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Pet
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Player
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Totem
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Unit
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Vehicle
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Transport
  ${CMAKE_SOURCE_DIR}/src/game/Events
  ${CMAKE_SOURCE_DIR}/src/game/Globals
  ${CMAKE_SOURCE_DIR}/src/game/Grids/Cells
  ${CMAKE_SOURCE_DIR}/src/game/Grids/Notifiers
  ${CMAKE_SOURCE_DIR}/src/game/Grids
  ${CMAKE_SOURCE_DIR}/src/game/Groups
  ${CMAKE_SOURCE_DIR}/src/game/Guilds
  ${CMAKE_SOURCE_DIR}/src/game/Handlers
  ${CMAKE_SOURCE_DIR}/src/game/Instances
  ${CMAKE_SOURCE_DIR}/src/game/Loot
  ${CMAKE_SOURCE_DIR}/src/game/Mails
  ${CMAKE_SOURCE_DIR}/src/game/Maps
  ${CMAKE_SOURCE_DIR}/src/game/Miscellaneous
  ${CMAKE_SOURCE_DIR}/src/game/Movement
  ${CMAKE_SOURCE_DIR}/src/game/Movement/Spline
  ${CMAKE_SOURCE_DIR}/src/game/Movement/MovementGenerators
  ${CMAKE_SOURCE_DIR}/src/game/Movement/Waypoints
  ${CMAKE_SOURCE_DIR}/src/game/OutdoorPvP
  ${CMAKE_SOURCE_DIR}/src/game/Pools
  ${CMAKE_SOURCE_DIR}/src/game/PrecompiledHeaders
  ${CMAKE_SOURCE_DIR}/src/game/Quests
  ${CMAKE_SOURCE_DIR}/src/game/Reputation
  ${CMAKE_SOURCE_DIR}/src/game/Scripting
  ${CMAKE_SOURCE_DIR}/src/game/Server/Protocol
  ${CMAKE_SOURCE_DIR}/src/game/Server
  ${CMAKE_SOURCE_DIR}/src/game/Skills
  ${CMAKE_SOURCE_DIR}/src/game/Spells
  ${CMAKE_SOURCE_DIR}/src/game/Spells/Auras
  ${CMAKE_SOURCE_DIR}/src/game/Tools
  ${CMAKE_SOURCE_DIR}/src/game/Warden
  ${CMAKE_SOURCE_DIR}/src/game/Warden/Modules
  ${CMAKE_SOURCE_DIR}/src/game/Weather
  ${CMAKE_SOURCE_DIR}/src/game/World
  ${CMAKE_SOURCE_DIR}/src/game/Misc
  ${CMAKE_SOURCE_DIR}/src/scripts/PrecompiledHeaders
  ${CMAKE_SOURCE_DIR}/src/authserver/Server
  ${CMAKE_SOURCE_DIR}/src/authserver/Realms
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/CommandLine
  ${CMAKE_CURRENT_SOURCE_DIR}/RemoteAccess
  ${CMAKE_CURRENT_SOURCE_DIR}/TCSoap
  ${CMAKE_CURRENT_SOURCE_DIR}/WorldThread
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}
  ${OPENSSL_INCLUDE_DIR}
)

add_executable(worldserver
  ${worldserver_SRCS}
  ${worldserver_PCH_SRC}
)

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
  game
  shared
  scripts
  collision
  g3dlib
  gsoap
  Detour
  ${GPERFTOOLS_LIBRARIES}
  ${JEMALLOC_LIBRARY}
  ${READLINE_LIBRARY}
  ${TERMCAP_LIBRARY}
  ${ACE_LIBRARY}
  ${MYSQL_LIBRARY}
  ${OPENSSL_LIBRARIES}
  ${ZLIB_LIBRARIES}
  ${CMAKE_THREAD_LIBS_INIT}
)

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
  add_cxx_pch(worldserver ${worldserver_PCH_HDR} ${worldserver_PCH_SRC})
endif()

CU_RUN_HOOK("AFTER_WORLDSERVER_CMAKE")
