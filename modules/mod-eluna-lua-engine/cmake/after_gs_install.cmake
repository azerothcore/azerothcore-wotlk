set(PUBLIC_INCLUDES
    ${PUBLIC_INCLUDES}
    ${CMAKE_MOD_ELUNA_ENGINE_DIR}/LuaEngine
    ${CMAKE_MOD_ELUNA_ENGINE_DIR}/lualib
)

target_include_directories(game-interface
  INTERFACE
    ${PUBLIC_INCLUDES})

add_dependencies(game lualib)

target_link_libraries(game
  PUBLIC
    lualib)

if( WIN32 )
  if (MSVC)
    set(MSVC_CONFIGURATION_NAME $(ConfigurationName)/)
  endif()
  add_custom_command(TARGET game
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/${MSVC_CONFIGURATION_NAME}lua_scripts/extensions/"
  COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_MOD_ELUNA_ENGINE_DIR}/LuaEngine/extensions" "${CMAKE_BINARY_DIR}/bin/${MSVC_CONFIGURATION_NAME}lua_scripts/extensions/"
 )
endif()

install(DIRECTORY "${CMAKE_MOD_ELUNA_ENGINE_DIR}/LuaEngine/extensions" DESTINATION "${CMAKE_INSTALL_PREFIX}/bin/lua_scripts/")
