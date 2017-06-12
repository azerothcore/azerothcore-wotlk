# Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

file(GLOB_RECURSE sources_playerbot playerbot/*.cpp playerbot/*.h)
file(GLOB_RECURSE sources_pch pch/*.cpp pch/*.h)

set(bot_STAT_SRCS
  ${bot_STAT_SRCS}  
  ${sources_playerbot}
  ${sources_pch}
)


if (USE_COREPCH)
  set(PRIVATE_PCH_HEADER pch/pch.h)
  set(PRIVATE_PCH_SOURCE pch/pch.cpp)
endif()

include_directories(
   ${game_INCLUDE_DIRS}
  ${CMAKE_BINARY_DIR}
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/recastnavigation/Detour
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/recastnavigation/Recast
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/g3dlite/include
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/SFMT
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/zlib
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Management
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Models
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Maps
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
  ${CMAKE_SOURCE_DIR}
  ${CMAKE_SOURCE_DIR}/src/game/Accounts
  ${CMAKE_SOURCE_DIR}/src/game/Achievements
  ${CMAKE_SOURCE_DIR}/src/game/AI
  ${CMAKE_SOURCE_DIR}/src/game/AI/CoreAI
  ${CMAKE_SOURCE_DIR}/src/game/AI/ScriptedAI
  ${CMAKE_SOURCE_DIR}/src/game/AI/SmartScripts
  ${CMAKE_SOURCE_DIR}/src/game/AuctionHouse
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
  ${CMAKE_SOURCE_DIR}/src/game/Petitions
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
  ${CMAKE_SOURCE_DIR}/src/game/Texts
  ${CMAKE_SOURCE_DIR}/src/game/Tools
  ${CMAKE_SOURCE_DIR}/src/game/Tickets
  ${CMAKE_SOURCE_DIR}/src/game/Warden
  ${CMAKE_SOURCE_DIR}/src/game/Warden/Modules
  ${CMAKE_SOURCE_DIR}/src/game/Weather
  ${CMAKE_SOURCE_DIR}/src/game/World
  ${CMAKE_SOURCE_DIR}/src/game/ArenaSpectator
  ${CMAKE_SOURCE_DIR}/src/game/Misc
  ${CMAKE_SOURCE_DIR}/src/scripts/
  ${CMAKE_SOURCE_DIR}/src/scripts/PrecompiledHeaders
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}
  ${OPENSSL_INCLUDE_DIR}
)

add_library(bot STATIC
  ${bot_STAT_SRCS}
  ${bot_STAT_PCH_SRC}
)


# Do NOT add any extra include directory unless it does not create unneeded extra dependencies,
# and specially, not add any dependency to neither of these: shared, game, scripts
# This way we ensure that if either a PR does that without modifying this file,
# a compile error will be generated, either this file will be modified so it
# is detected more easily.
# While it is OK to include files from other libs as long as they don't require
# linkage (enums, defines...) it is discouraged to do so unless necessary, as it will pullute
# include_directories leading to further unnoticed dependency aditions
# Linker Depencency requirements: common

target_include_directories(bot
  PUBLIC
    ${PUBLIC_INCLUDES}
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

add_definitions(-DTRINITY_API_EXPORT_bot)

target_link_libraries(bot
  ${MYSQL_LIBRARY})

set_target_properties(bot
    PROPERTIES
      FOLDER
        "server")

if( BUILD_SHARED_LIBS )
  if( UNIX )
    install(TARGETS bot
      LIBRARY
        DESTINATION lib)
  elseif( WIN32 )
    install(TARGETS bot
      RUNTIME
        DESTINATION "${CMAKE_INSTALL_PREFIX}")
  endif()
endif()

if( WIN32 )
  if ( MSVC )
    add_custom_command(TARGET bot
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/playerbot/aiplayerbot.conf.dist ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/
    )
  elseif ( MINGW )
    add_custom_command(TARGET bot
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/playerbot/aiplayerbot.conf.dist ${CMAKE_BINARY_DIR}/bin/
    )
  endif()
endif()

# Generate precompiled header
if (USE_COREPCH)
  add_cxx_pch(bot ${PRIVATE_PCH_HEADER} ${PRIVATE_PCH_SOURCE})
endif ()
