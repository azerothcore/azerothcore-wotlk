CU_SET_PATH("CMAKE_DOUBLE_XP_WEEKEND_DIR" "${CMAKE_CURRENT_LIST_DIR}")

AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/mod-double-xp-weekend.cpp")

AC_ADD_SCRIPT_LOADER("doublexp"    "${CMAKE_CURRENT_LIST_DIR}/src/loader.h")

AC_ADD_CONFIG_FILE("${CMAKE_CURRENT_LIST_DIR}/conf/mod-double-xp-weekend.conf.dist")
