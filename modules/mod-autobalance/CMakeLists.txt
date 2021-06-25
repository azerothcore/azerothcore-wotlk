AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/AutoBalance.cpp")
AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/AutoBalance.h")
AC_ADD_SCRIPT_LOADER("AutoBalance" "${CMAKE_CURRENT_LIST_DIR}/src/loader.h")

AC_ADD_CONFIG_FILE("${CMAKE_CURRENT_LIST_DIR}/conf/AutoBalance.conf.dist")
