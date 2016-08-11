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
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPTF.cpp
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPSI.cpp
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPSI.h
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPZM.cpp
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPNA.cpp
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPHP.cpp
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPTF.h
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPEP.h
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPEP.cpp
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPHP.h
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPZM.h
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPNA.h
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPGH.cpp
  ${CMAKE_AC_MODULE_DIR}/OutdoorPvP/OutdoorPvPGH.h
)

AC_ADD_SCRIPT_LOADER("OutdoorPvP" "${CMAKE_AC_MODULE_DIR}/ScriptWotlkLoader.h")

message("  -> Prepared: Outdoor PVP Zones")
