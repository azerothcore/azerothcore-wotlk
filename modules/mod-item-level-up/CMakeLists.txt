CU_SET_PATH("CMAKE_LevelItem_DIR" "${CMAKE_CURRENT_LIST_DIR}")

AC_ADD_SCRIPT("${CMAKE_CURRENT_LIST_DIR}/src/mod_levelitem.cpp")

AC_ADD_SCRIPT_LOADER("LevelItem"      "${CMAKE_CURRENT_LIST_DIR}/src/loader_levelitem.h")

CU_ADD_HOOK(AFTER_WORLDSERVER_CMAKE "${CMAKE_CURRENT_LIST_DIR}/src/cmake/after_ws_install.cmake")

message("-- LevelItem --")
