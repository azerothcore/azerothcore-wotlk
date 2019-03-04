add_subdirectory(${CMAKE_MOD_ELUNA_ENGINE_DIR}/lualib)
add_definitions(-DELUNA)
add_definitions(-DAZEROTHCORE)
add_definitions(-DWOTLK)
CU_ADD_HOOK(BEFORE_GAME_LIBRARY "${CMAKE_MOD_ELUNA_ENGINE_DIR}/cmake/before_gs_install.cmake")
CU_ADD_HOOK(AFTER_GAME_LIBRARY "${CMAKE_MOD_ELUNA_ENGINE_DIR}/cmake/after_gs_install.cmake")
CU_ADD_HOOK(BEFORE_SCRIPTS_LIBRARY "${CMAKE_MOD_ELUNA_ENGINE_DIR}/cmake/before_script_install.cmake")
CU_ADD_HOOK(AFTER_WORLDSERVER_CMAKE "${CMAKE_MOD_ELUNA_ENGINE_DIR}/cmake/after_ws_install.cmake")

AC_ADD_CONFIG_FILE("${CMAKE_MOD_ELUNA_ENGINE_DIR}/conf/mod_LuaEngine.conf.dist")

message("** [Eluna Module] LuaEngine is enable!")

