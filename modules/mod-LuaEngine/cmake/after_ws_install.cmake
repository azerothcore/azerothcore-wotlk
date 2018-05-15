
include_directories(
  ${CMAKE_MOD_ELUNA_ENGINE_DIR}
  ${CMAKE_MOD_ELUNA_ENGINE_DIR}/LuaEngine
  ${CMAKE_MOD_ELUNA_ENGINE_DIR}/lualib
)

if( WIN32 )
  if ( MSVC )
    add_custom_command(TARGET worldserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_MOD_ELUNA_ENGINE_DIR}/conf/mod_LuaEngine.conf.dist" ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/
    )
  elseif ( MINGW )
    add_custom_command(TARGET worldserver
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_MOD_ELUNA_ENGINE_DIR}/conf/mod_LuaEngine.conf.dist" ${CMAKE_BINARY_DIR}/bin/
    )
  endif()
endif()

install(FILES "${CMAKE_MOD_ELUNA_ENGINE_DIR}/conf/mod_LuaEngine.conf.dist" DESTINATION ${CONF_DIR})