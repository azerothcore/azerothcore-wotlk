# Copyright (C) 
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${CMAKE_AC_MODULE_DIR}/World/achievement_scripts.cpp
  ${CMAKE_AC_MODULE_DIR}/World/areatrigger_scripts.cpp
  ${CMAKE_AC_MODULE_DIR}/World/boss_emerald_dragons.cpp
  ${CMAKE_AC_MODULE_DIR}/World/go_scripts.cpp
  ${CMAKE_AC_MODULE_DIR}/World/guards.cpp
  ${CMAKE_AC_MODULE_DIR}/World/item_scripts.cpp
  ${CMAKE_AC_MODULE_DIR}/World/mob_generic_creature.cpp
  ${CMAKE_AC_MODULE_DIR}/World/npc_innkeeper.cpp
  ${CMAKE_AC_MODULE_DIR}/World/npc_professions.cpp
  ${CMAKE_AC_MODULE_DIR}/World/npc_taxi.cpp
  ${CMAKE_AC_MODULE_DIR}/World/npcs_special.cpp
)

AC_ADD_SCRIPT_LOADER("World" "ScriptLoader.h")

message("  -> Prepared: World")
