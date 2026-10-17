#
# This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

# Builds the voiceserver parts of the modules into the voicemodules library,
# which the voiceserver links. Included from CMakeLists.txt.
#
# - a module's voiceserver code lives in src/voiceserver/, which the
#   worldserver build leaves out
# - it creates its scripts (see VoiceScript.h) from
#     void Add<module>VoiceScripts()
#   where <module> is the module directory name with '-' replaced by '_'
# - headers directly in src/ are visible to both halves of a module
# - voiceserver configs go in conf/voiceserver/*.conf.dist and are installed
#   to configs/modules/voiceserver/
#
# Voiceserver parts are always linked statically. A disabled module has no
# voiceserver part either.

set(VOICE_MODULES_LIST "")
set(VOICE_MODULES_SOURCES "")
set(VOICE_MODULES_INCLUDES "")

foreach(SOURCE_MODULE ${MODULES_MODULE_LIST})
  ModuleNameToVariable(${SOURCE_MODULE} MODULE_MODULE_VARIABLE)
  set(VOICE_MODULE_LINKAGE "${${MODULE_MODULE_VARIABLE}}")
  if (NOT VOICE_MODULE_LINKAGE OR VOICE_MODULE_LINKAGE STREQUAL "default")
    set(VOICE_MODULE_LINKAGE ${MODULES_DEFAULT_LINKAGE})
  endif()

  GetPathToModuleSource(${SOURCE_MODULE} MODULE_SOURCE_PATH)
  if (VOICE_MODULE_LINKAGE STREQUAL "disabled" OR NOT IS_DIRECTORY "${MODULE_SOURCE_PATH}/voiceserver")
    continue()
  endif()

  list(APPEND VOICE_MODULES_LIST ${SOURCE_MODULE})
  CollectSourceFiles(${MODULE_SOURCE_PATH}/voiceserver VOICE_MODULES_SOURCES)
  CollectIncludeDirectories(${MODULE_SOURCE_PATH}/voiceserver VOICE_MODULES_INCLUDES)
  list(APPEND VOICE_MODULES_INCLUDES ${MODULE_SOURCE_PATH})
endforeach()

# Generate the loader calling the Add<module>VoiceScripts() functions
set(VOICE_MODULES_FORWARD_DECL "")
set(VOICE_MODULES_INVOKE "")
foreach(VOICE_MODULE ${VOICE_MODULES_LIST})
  string(REPLACE "-" "_" VOICE_MODULE_NAME ${VOICE_MODULE})
  set(VOICE_MODULES_FORWARD_DECL "${VOICE_MODULES_FORWARD_DECL}void Add${VOICE_MODULE_NAME}VoiceScripts();\n")
  set(VOICE_MODULES_INVOKE "${VOICE_MODULES_INVOKE}    Add${VOICE_MODULE_NAME}VoiceScripts();\n")
endforeach()

set(VOICE_MODULES_LOADER ${CMAKE_CURRENT_BINARY_DIR}/gen_scriptloader/voiceserver/VoiceModulesLoader.cpp)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/VoiceModulesLoader.cpp.in.cmake ${VOICE_MODULES_LOADER} @ONLY)

add_library(voicemodules STATIC
  VoiceModulesLoader.h
  ${VOICE_MODULES_LOADER}
  ${VOICE_MODULES_SOURCES})

target_link_libraries(voicemodules
  PRIVATE
    acore-core-interface
  PUBLIC
    services)

target_include_directories(voicemodules
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${VOICE_MODULES_INCLUDES})

set_target_properties(voicemodules
  PROPERTIES
    FOLDER
      "modules")

# Installs a voiceserver config of a module to configs/modules/voiceserver/
function(CopyVoiceModuleConfig configFile)
  set(postPath "configs/modules/voiceserver")

  if(WIN32)
    if("${CMAKE_MAKE_PROGRAM}" MATCHES "MSBuild")
      add_custom_command(TARGET voicemodules
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/${postPath}")
      add_custom_command(TARGET voicemodules
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${configFile}" "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/${postPath}")
    elseif(MINGW)
      add_custom_command(TARGET voicemodules
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/bin/${postPath}")
      add_custom_command(TARGET voicemodules
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${configFile}" "${CMAKE_BINARY_DIR}/bin/${postPath}")
    endif()
  endif()

  if(UNIX)
    install(FILES "${configFile}" DESTINATION "${CONF_DIR}/modules/voiceserver")
  elseif(WIN32)
    install(FILES "${configFile}" DESTINATION "${CMAKE_INSTALL_PREFIX}/${postPath}")
  endif()
endfunction()

set(VOICE_MODULES_CONFIG_LIST "")

message(STATUS "* Voiceserver modules:
  |")

foreach(VOICE_MODULE ${VOICE_MODULES_LIST})
  message(STATUS "  +- ${VOICE_MODULE}")

  set(VOICE_MODULE_CONFIG_PATH "${CMAKE_SOURCE_DIR}/modules/${VOICE_MODULE}/conf/voiceserver")
  file(GLOB VOICE_MODULE_CONFIGS RELATIVE ${VOICE_MODULE_CONFIG_PATH} ${VOICE_MODULE_CONFIG_PATH}/*.conf.dist)

  foreach(configFileName ${VOICE_MODULE_CONFIGS})
    CopyVoiceModuleConfig("${VOICE_MODULE_CONFIG_PATH}/${configFileName}")
    string(REGEX REPLACE "\\.dist$" "" configFileName ${configFileName})
    set(VOICE_MODULES_CONFIG_LIST "${VOICE_MODULES_CONFIG_LIST}voiceserver/${configFileName},")
    message(STATUS "  |  * ${configFileName}")
  endforeach()
endforeach()

message("")

# The voiceserver loads these from its modules config directory
target_compile_options(voicemodules
  INTERFACE
    -DVOICE_CONFIG_FILE_LIST=$<1:"${VOICE_MODULES_CONFIG_LIST}">)
