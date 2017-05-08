# Copyright (C)
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# Enable precompiled headers when using the GCC compiler.

CU_RUN_HOOK(BEFORE_SCRIPTS_LIBRARY)

CU_SET_PATH("AC_SCRIPTS_DIR" "${CMAKE_CURRENT_LIST_DIR}")

if (USE_SCRIPTPCH)
  set(scripts_STAT_PCH_HDR PrecompiledHeaders/ScriptPCH.h)
  set(scripts_STAT_PCH_SRC PrecompiledHeaders/ScriptPCH.cpp)
endif ()

message(STATUS "SCRIPT PREPARATIONS")
include(Spells/CMakeLists.txt)

include(Commands/CMakeLists.txt)

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ScriptLoader.cpp
  ScriptLoader.h
  ${BUILDDIR}/GenLoader.cpp
  ../game/AI/ScriptedAI/ScriptedEscortAI.cpp
  ../game/AI/ScriptedAI/ScriptedCreature.cpp
  ../game/AI/ScriptedAI/ScriptedFollowerAI.cpp
)

AC_ADD_SCRIPT_LOADER("Spell" "ScriptLoader.h")
AC_ADD_SCRIPT_LOADER("SC_Smart" "ScriptLoader.h")
AC_ADD_SCRIPT_LOADER("Command" "ScriptLoader.h")

CU_SET_PATH("CMAKE_AC_MODULE_DIR" "${CMAKE_CURRENT_LIST_DIR}")

if(SCRIPTS)
  include(Custom/CMakeLists.txt)
  include(World/CMakeLists.txt)
  include(OutdoorPvP/CMakeLists.txt)
  include(EasternKingdoms/CMakeLists.txt)
  include(Kalimdor/CMakeLists.txt)
  include(Outland/CMakeLists.txt)
  include(Northrend/CMakeLists.txt)
  include(Events/CMakeLists.txt)
  include(Pet/CMakeLists.txt)
endif()

CU_GET_GLOBAL("AC_ADD_SCRIPTS_LIST")
CU_GET_GLOBAL("AC_ADD_SCRIPTS_INCLUDE")
CU_GET_GLOBAL("AC_SCRIPTS_SOURCES")

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${AC_SCRIPTS_SOURCES}
)

set("AC_SCRIPTS_INCLUDES" "")

FOREACH (include ${AC_ADD_SCRIPTS_INCLUDE})
    set("AC_SCRIPTS_INCLUDES" "#include \"${include}\"\n${AC_SCRIPTS_INCLUDES}")
ENDFOREACH()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/GenLoader.cpp.cmake ${BUILDDIR}/GenLoader.cpp)

message(STATUS "SCRIPT PREPARATION COMPLETE")
message("")

include_directories(
  ${scripts_INCLUDE_DIRS}
  ${CMAKE_BINARY_DIR}
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/recastnavigation/Detour
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/recastnavigation/Recast
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/g3dlite/include
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/SFMT
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/zlib
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Configuration
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Cryptography
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Database
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/DataStores
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Debugging
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Dynamic/LinkedReference
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Dynamic
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Logging
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Packets
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Threading
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Utilities
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Management
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Models
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Database
  ${CMAKE_SOURCE_DIR}/modules/acore/game-framework/src/Addons
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
  ${CMAKE_SOURCE_DIR}/src/game/Conditions
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Configuration
  ${CMAKE_SOURCE_DIR}/src/game/Combat
  ${CMAKE_SOURCE_DIR}/src/game/DataStores
  ${CMAKE_SOURCE_DIR}/src/game/DungeonFinding
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Corpse
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Creature
  ${CMAKE_SOURCE_DIR}/src/game/Entities/DynamicObject
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Item
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Item/Container
  ${CMAKE_SOURCE_DIR}/src/game/Entities/GameObject
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Object
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Object/Updates
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Pet
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Player
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Totem
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Transport
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Unit
  ${CMAKE_SOURCE_DIR}/src/game/Entities/Vehicle
  ${CMAKE_SOURCE_DIR}/src/game/Events
  ${CMAKE_SOURCE_DIR}/src/game/Globals
  ${CMAKE_SOURCE_DIR}/src/game/Grids
  ${CMAKE_SOURCE_DIR}/src/game/Grids/Cells
  ${CMAKE_SOURCE_DIR}/src/game/Grids/Notifiers
  ${CMAKE_SOURCE_DIR}/src/game/Groups
  ${CMAKE_SOURCE_DIR}/src/game/Guilds
  ${CMAKE_SOURCE_DIR}/src/game/Handlers
  ${CMAKE_SOURCE_DIR}/src/game/Instances
  ${CMAKE_SOURCE_DIR}/src/game/LookingForGroup
  ${CMAKE_SOURCE_DIR}/src/game/Loot
  ${CMAKE_SOURCE_DIR}/src/game/Mails
  ${CMAKE_SOURCE_DIR}/src/game/Miscellaneous
  ${CMAKE_SOURCE_DIR}/src/game/Maps
  ${CMAKE_SOURCE_DIR}/src/game/Movement
  ${CMAKE_SOURCE_DIR}/src/game/Movement/MovementGenerators
  ${CMAKE_SOURCE_DIR}/src/game/Movement/Spline
  ${CMAKE_SOURCE_DIR}/src/game/Movement/Waypoints
  ${CMAKE_SOURCE_DIR}/src/game/Opcodes
  ${CMAKE_SOURCE_DIR}/src/game/OutdoorPvP
  ${CMAKE_SOURCE_DIR}/src/game/Petitions
  ${CMAKE_SOURCE_DIR}/src/game/Pools
  ${CMAKE_SOURCE_DIR}/src/game/PrecompiledHeaders
  ${CMAKE_SOURCE_DIR}/src/game/Quests
  ${CMAKE_SOURCE_DIR}/src/game/Reputation
  ${CMAKE_SOURCE_DIR}/src/game/Scripting
  ${CMAKE_SOURCE_DIR}/src/game/Server
  ${CMAKE_SOURCE_DIR}/src/game/Server/Protocol
  ${CMAKE_SOURCE_DIR}/src/game/Skills
  ${CMAKE_SOURCE_DIR}/src/game/Spells
  ${CMAKE_SOURCE_DIR}/src/game/Spells/Auras
  ${CMAKE_SOURCE_DIR}/src/game/Texts
  ${CMAKE_SOURCE_DIR}/src/game/Tickets
  ${CMAKE_SOURCE_DIR}/src/game/Tools
  ${CMAKE_SOURCE_DIR}/src/game/Warden
  ${CMAKE_SOURCE_DIR}/src/game/Warden/Modules
  ${CMAKE_SOURCE_DIR}/src/game/Weather
  ${CMAKE_SOURCE_DIR}/src/game/World
  ${CMAKE_SOURCE_DIR}/src/game/ArenaSpectator
  ${CMAKE_SOURCE_DIR}/src/game/Misc
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}
)

add_library(scripts STATIC
  ${scripts_STAT_SRCS}
  ${scripts_STAT_PCH_SRC}
)

add_dependencies(scripts revision.h)

# Generate precompiled header
if (USE_SCRIPTPCH)
  add_cxx_pch(scripts ${scripts_STAT_PCH_HDR} ${scripts_STAT_PCH_SRC})
endif()
