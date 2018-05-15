
include_directories(
	${CMAKE_MOD_ELUNA_ENGINE_DIR}
	${CMAKE_MOD_ELUNA_ENGINE_DIR}/LuaEngine
	${CMAKE_MOD_ELUNA_ENGINE_DIR}/lualib
)


add_dependencies(game lualib)
target_link_libraries(game lualib)

if( WIN32 )
	if ( MSVC )
		add_custom_command(TARGET game
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/lua_scripts/extensions/"
		COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_MOD_ELUNA_ENGINE_DIR}/LuaEngine/extensions" "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/lua_scripts/extensions/"
	)
	elseif ( MINGW )
		add_custom_command(TARGET game
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/lua_scripts/extensions/"
		COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_MOD_ELUNA_ENGINE_DIR}/LuaEngine/extensions" "${CMAKE_BINARY_DIR}/bin/lua_scripts/extensions/"
	)
	endif()
endif()

install(DIRECTORY "${CMAKE_MOD_ELUNA_ENGINE_DIR}/LuaEngine/extensions" DESTINATION "${CMAKE_INSTALL_PREFIX}/bin/lua_scripts/")
