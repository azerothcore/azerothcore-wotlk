#
# Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
#

# Add scripts in project
AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/LootBoxWorld.cpp")
AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/LootBoxPlayer.cpp")
AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/LootBoxItem.cpp")

# Add scripts to script loader
AC_ADD_SCRIPT_LOADER("LootBox" "${CMAKE_CURRENT_LIST_DIR}/src/loader.h")

# Add config file
AC_ADD_CONFIG_FILE("${CMAKE_CURRENT_LIST_DIR}/conf/LootBox.conf.dist")
