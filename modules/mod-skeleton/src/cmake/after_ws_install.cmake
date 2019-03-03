if ( MSVC )
  add_custom_command(TARGET worldserver
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_MOD_SKELETON_DIR}/conf/mod_skeleton.conf.dist ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/
  )
elseif ( MINGW )
  add_custom_command(TARGET worldserver
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_MOD_SKELETON_DIR}/conf/mod_skeleton.conf.dist ${CMAKE_BINARY_DIR}/bin/
  )
endif()

install(FILES "${CMAKE_MOD_SKELETON_DIR}/conf/mod_skeleton.conf.dist" DESTINATION ${CONF_DIR})
