#
# This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

#
# Use it like:
# CopyDefaultConfig(worldserver)
#

function(CopyDefaultConfig servertype)
  if(WIN32)
    if("${CMAKE_MAKE_PROGRAM}" MATCHES "MSBuild")
      add_custom_command(TARGET ${servertype}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/configs")
      add_custom_command(TARGET ${servertype}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/${servertype}.conf.dist" "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/configs")
    elseif(MINGW)
      add_custom_command(TARGET ${servertype}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/configs")
      add_custom_command(TARGET ${servertype}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/${servertype}.conf.dist ${CMAKE_BINARY_DIR}/bin/configs")
    endif()
  endif()

  if(UNIX)
    install(FILES "${servertype}.conf.dist" DESTINATION "${CONF_DIR}")
  elseif(WIN32)
    install(FILES "${servertype}.conf.dist" DESTINATION "${CMAKE_INSTALL_PREFIX}/configs")
  endif()
endfunction()

#
# Use it like:
# CopyModuleConfig("warhead.conf.dist")
#

function(CopyModuleConfig configDir)
  set(postPath "configs/modules")

  if(WIN32)
    if("${CMAKE_MAKE_PROGRAM}" MATCHES "MSBuild")
      add_custom_command(TARGET worldserver
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/${postPath}")
      add_custom_command(TARGET worldserver
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${configDir}" "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/${postPath}")
    elseif(MINGW)
      add_custom_command(TARGET worldserver
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/${postPath}")
      add_custom_command(TARGET worldserver
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${configDir} ${CMAKE_BINARY_DIR}/bin/${postPath}")
    endif()
  endif()

  if(UNIX)
    install(FILES "${configDir}" DESTINATION "${CONF_DIR}/modules")
  elseif(WIN32)
    install(FILES "${configDir}" DESTINATION "${CMAKE_INSTALL_PREFIX}/${postPath}")
  endif()
  unset(postPath)
endfunction()

#
# Use it like:
# CollectModulesConfig(${CMAKE_CURRENT_SOURCE_DIR})
#

function(CollectModulesConfig)
  message(STATUS "* Modules config list:")

  CU_GET_GLOBAL("MODULE_CONFIG_FILE_LIST")

  foreach(configFile ${MODULE_CONFIG_FILE_LIST})
    CopyModuleConfig(${configFile})
    get_filename_component(file_name ${configFile} NAME)
    set(CONFIG_LIST ${CONFIG_LIST}${file_name},)
    message(STATUS "  |- ${file_name}")
  endforeach()

  message("")
  add_definitions(-DCONFIG_FILE_LIST=$<1:"${CONFIG_LIST}">)
endfunction()
