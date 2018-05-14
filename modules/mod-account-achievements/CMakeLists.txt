CU_SET_PATH("CMAKE_MOD_ACHIEVEMENTS_DIR" "${CMAKE_CURRENT_LIST_DIR}")

AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/mod_achievements.cpp")

AC_ADD_SCRIPT_LOADER("AccountAchievements" "${CMAKE_CURRENT_LIST_DIR}/src/loader_achievements.h")

CU_ADD_HOOK(AFTER_WORLDSERVER_CMAKE "${CMAKE_CURRENT_LIST_DIR}/src/cmake/after_ws_install.cmake")