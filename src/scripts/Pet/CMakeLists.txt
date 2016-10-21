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
  ${AC_SCRIPTS_DIR}/Pet/pet_dk.cpp
  ${AC_SCRIPTS_DIR}/Pet/pet_generic.cpp
  ${AC_SCRIPTS_DIR}/Pet/pet_hunter.cpp
  ${AC_SCRIPTS_DIR}/Pet/pet_mage.cpp
  ${AC_SCRIPTS_DIR}/Pet/pet_priest.cpp
  ${AC_SCRIPTS_DIR}/Pet/pet_shaman.cpp
)

AC_ADD_SCRIPT_LOADER("Pet" "ScriptLoader.h")

message("  -> Prepared: Pet")
