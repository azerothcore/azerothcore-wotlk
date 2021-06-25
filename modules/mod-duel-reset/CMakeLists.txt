# Add cpp files
AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/DuelReset.cpp")
AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/DuelReset_scripts.cpp")
AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/DuelReset.h")

# Add scripts to script loader
AC_ADD_SCRIPT_LOADER("DuelReset" "${CMAKE_CURRENT_LIST_DIR}/src/loader.h")

# Add config file
AC_ADD_CONFIG_FILE("${CMAKE_CURRENT_LIST_DIR}/conf/duelreset.conf.dist")