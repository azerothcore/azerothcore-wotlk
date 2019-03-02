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
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPTF.cpp
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPSI.cpp
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPSI.h
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPZM.cpp
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPNA.cpp
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPHP.cpp
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPTF.h
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPEP.h
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPEP.cpp
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPHP.h
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPZM.h
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPNA.h
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPGH.cpp
  ${AC_SCRIPTS_DIR}/OutdoorPvP/OutdoorPvPGH.h
)

AC_ADD_SCRIPT_LOADER("OutdoorPvP" "ScriptLoader.h")

message("  -> Prepared: Outdoor PVP Zones")
