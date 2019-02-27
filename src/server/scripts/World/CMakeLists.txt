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
  ${AC_SCRIPTS_DIR}/World/achievement_scripts.cpp
  ${AC_SCRIPTS_DIR}/World/areatrigger_scripts.cpp
  ${AC_SCRIPTS_DIR}/World/boss_emerald_dragons.cpp
  ${AC_SCRIPTS_DIR}/World/chat_log.cpp
  ${AC_SCRIPTS_DIR}/World/go_scripts.cpp
  ${AC_SCRIPTS_DIR}/World/guards.cpp
  ${AC_SCRIPTS_DIR}/World/item_scripts.cpp
  ${AC_SCRIPTS_DIR}/World/mob_generic_creature.cpp
  ${AC_SCRIPTS_DIR}/World/npc_innkeeper.cpp
  ${AC_SCRIPTS_DIR}/World/npc_professions.cpp
  ${AC_SCRIPTS_DIR}/World/npc_taxi.cpp
  ${AC_SCRIPTS_DIR}/World/npcs_special.cpp
  ${AC_SCRIPTS_DIR}/World/character_creation.cpp
  ${AC_SCRIPTS_DIR}/World/action_ip_logger.cpp
)

AC_ADD_SCRIPT_LOADER("World" "ScriptLoader.h")

message("  -> Prepared: World")
