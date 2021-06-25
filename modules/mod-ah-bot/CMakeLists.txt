#
#
#

# Set path
CU_SET_PATH("CMAKE_MOD_AHBOT_DIR" "${CMAKE_CURRENT_LIST_DIR}")

# CMake hooks
CU_ADD_HOOK(AFTER_GAME_LIBRARY "${CMAKE_MOD_AHBOT_DIR}/cmake/after_game_lib.cmake")

# Add SC
AC_ADD_SCRIPT("${CMAKE_MOD_AHBOT_DIR}/src/cs_ah_bot.cpp")
AC_ADD_SCRIPT("${CMAKE_MOD_AHBOT_DIR}/src/AuctionHouseBot.cpp")
AC_ADD_SCRIPT("${CMAKE_MOD_AHBOT_DIR}/src/AuctionHouseBot.h")
AC_ADD_SCRIPT("${CMAKE_MOD_AHBOT_DIR}/src/AuctionHouseBotScript.cpp")

# Add SL
AC_ADD_SCRIPT_LOADER("AHBotCommand" "${CMAKE_MOD_AHBOT_DIR}/src/loader_cs_ah_bot.h")
AC_ADD_SCRIPT_LOADER("AHBot" "${CMAKE_MOD_AHBOT_DIR}/src/loader_ah_bot.h")

# Add conf file
AC_ADD_CONFIG_FILE("${CMAKE_MOD_AHBOT_DIR}/conf/mod_ahbot.conf.dist")
