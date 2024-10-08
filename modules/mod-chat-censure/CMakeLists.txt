AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/ChatCensure.cpp")
AC_ADD_SCRIPT_LOADER("MyChatCensure" "${CMAKE_CURRENT_LIST_DIR}/src/loader.h")

AC_ADD_CONFIG_FILE("${CMAKE_CURRENT_LIST_DIR}/conf/mod_ChatCensure.conf.dist")