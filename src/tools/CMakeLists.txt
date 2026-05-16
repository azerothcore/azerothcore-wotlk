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

# Make the tools list available in the current scope
GetToolsList(TOOLS_BUILD_LIST)

if (TOOLS_BUILD STREQUAL "none")
  set(TOOLS_DEFAULT_BUILD "disabled")
else()
  set(TOOLS_DEFAULT_BUILD "enabled")
endif()

# Sets BUILD_TOOLS_USE_WHITELIST
# Sets BUILD_TOOLS_WHITELIST
if (TOOLS_BUILD MATCHES "-only")
  set(BUILD_TOOLS_USE_WHITELIST ON)

  if (TOOLS_BUILD STREQUAL "maps-only")
    list(APPEND BUILD_TOOLS_WHITELIST map_extractor mmaps_generator vmap4_assembler vmap4_extractor)
  endif()

  if (TOOLS_BUILD STREQUAL "db-only")
    list(APPEND BUILD_TOOLS_WHITELIST dbimport)
  endif()
endif()

# Set the TOOL_${TOOL_BUILD_NAME} variables from the
# variables set above
foreach(TOOL_BUILD_NAME ${TOOLS_BUILD_LIST})
  ToolNameToVariable(${TOOL_BUILD_NAME} TOOL_BUILD_VARIABLE)

  if(${TOOL_BUILD_VARIABLE} STREQUAL "default")
    if(BUILD_TOOLS_USE_WHITELIST)
      list(FIND BUILD_TOOLS_WHITELIST "${TOOL_BUILD_NAME}" INDEX)
      if(${INDEX} GREATER -1)
        set(${TOOL_BUILD_VARIABLE} ${TOOLS_DEFAULT_BUILD})
      else()
        set(${TOOL_BUILD_VARIABLE} "disabled")
      endif()
    else()
      set(${TOOL_BUILD_VARIABLE} ${TOOLS_DEFAULT_BUILD})
    endif()
  endif()

  # Build the Graph values
  if(${TOOL_BUILD_VARIABLE} MATCHES "enabled")
    list(APPEND TOOL_BUILD_GRAPH_KEYS tools)
    set(TOOL_BUILD_VALUE_DISPLAY_tools tools)
    list(APPEND TOOL_BUILD_VALUE_CONTAINS_tools ${TOOL_BUILD_NAME})
  else()
    list(APPEND TOOL_BUILD_GRAPH_KEYS disabled)
    set(TOOL_BUILD_VALUE_DISPLAY_disabled disabled)
    list(APPEND TOOL_BUILD_VALUE_CONTAINS_disabled ${TOOL_BUILD_NAME})
  endif()
endforeach()

list(SORT TOOL_BUILD_GRAPH_KEYS)
list(REMOVE_DUPLICATES TOOL_BUILD_GRAPH_KEYS)

# Display the graphs
message("")
message("* Tools build list (${TOOLS_BUILD}):")
message("  |")

foreach(TOOL_BUILD_GRAPH_KEY ${TOOL_BUILD_GRAPH_KEYS})
  if(NOT TOOL_BUILD_GRAPH_KEY STREQUAL "disabled")
    message("  +- ${TOOL_BUILD_VALUE_DISPLAY_${TOOL_BUILD_GRAPH_KEY}}")
  else()
    message("  |  ${TOOL_BUILD_VALUE_DISPLAY_${TOOL_BUILD_GRAPH_KEY}}")
  endif()
  foreach(TOOL_BUILD_GRAPH_ENTRY ${TOOL_BUILD_VALUE_CONTAINS_${TOOL_BUILD_GRAPH_KEY}})
    message("  |   +- ${TOOL_BUILD_GRAPH_ENTRY}")
  endforeach()
  message("  |")
endforeach()

message("")

GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

# Generates the actual tools projects
foreach(TOOL_NAME ${TOOLS_BUILD_LIST})
  GetPathToTool(${TOOL_NAME} SOURCE_TOOL_PATH)
  ToolNameToVariable(${TOOL_NAME} TOOL_BUILD_VARIABLE)

  if (${TOOL_BUILD_VARIABLE} STREQUAL "disabled")
    continue()
  endif()

  unset(TOOL_PRIVATE_SOURCES)
  CollectSourceFiles(
    ${SOURCE_TOOL_PATH}
    TOOL_PRIVATE_SOURCES)

  if (WIN32)
    list(APPEND TOOL_PRIVATE_SOURCES ${winDebugging})
  endif()

  GetProjectNameOfToolName(${TOOL_NAME} TOOL_PROJECT_NAME)

  # Create the application project
  add_executable(${TOOL_PROJECT_NAME}
    ${TOOL_PRIVATE_SOURCES})

  add_dependencies(${TOOL_PROJECT_NAME} revision.h)

  # Need fix errors in maps tools
  # target_link_libraries(${TOOL_PROJECT_NAME}
  #   PRIVATE
  #     acore-dependency-interface)

  if (${TOOL_PROJECT_NAME} MATCHES "dbimport")
    target_link_libraries(${TOOL_PROJECT_NAME}
      PUBLIC
        database
      PRIVATE
        acore-core-interface)

    if (TARGET scripts)
      target_link_libraries(${TOOL_PROJECT_NAME}
        PRIVATE
          scripts)
    endif()

    if (TARGET modules)
      target_link_libraries(${TOOL_PROJECT_NAME}
        PRIVATE
          modules)
    else()
      GetModuleSourceList(DBIMPORT_MODULES_SOURCE_LIST)

      if(MODULES MATCHES "dynamic")
        set(DBIMPORT_MODULES_DEFAULT_LINKAGE "dynamic")
      elseif(MODULES MATCHES "static")
        set(DBIMPORT_MODULES_DEFAULT_LINKAGE "static")
      else()
        set(DBIMPORT_MODULES_DEFAULT_LINKAGE "disabled")
      endif()

      set(DBIMPORT_MODULES_LIST "")
      foreach(DBIMPORT_MODULE ${DBIMPORT_MODULES_SOURCE_LIST})
        ModuleNameToVariable(${DBIMPORT_MODULE} DBIMPORT_MODULE_VARIABLE)
        set(DBIMPORT_MODULE_LINKAGE "${${DBIMPORT_MODULE_VARIABLE}}")

        if(DBIMPORT_MODULE_LINKAGE STREQUAL "default" OR DBIMPORT_MODULE_LINKAGE STREQUAL "")
          set(DBIMPORT_MODULE_LINKAGE ${DBIMPORT_MODULES_DEFAULT_LINKAGE})
        endif()

        if(NOT DBIMPORT_MODULE_LINKAGE STREQUAL "disabled")
          string(APPEND DBIMPORT_MODULES_LIST "${DBIMPORT_MODULE},")
        endif()
      endforeach()

      target_compile_definitions(${TOOL_PROJECT_NAME}
        PRIVATE
          AC_MODULES_LIST="${DBIMPORT_MODULES_LIST}")
    endif()

    # Install config
    CopyToolConfig(${TOOL_PROJECT_NAME} ${TOOL_NAME})
  else()

    target_link_libraries(${TOOL_PROJECT_NAME}
    PRIVATE
      acore-dependency-interface)

    target_link_libraries(${TOOL_PROJECT_NAME}
      PUBLIC
        common
        mpq
        zlib
        Recast
        g3dlib
        fkYAML)
  endif()

  unset(TOOL_PUBLIC_INCLUDES)
  CollectIncludeDirectories(
    ${SOURCE_TOOL_PATH}
    TOOL_PUBLIC_INCLUDES)

  target_include_directories(${TOOL_PROJECT_NAME}
    PUBLIC
      ${CMAKE_CURRENT_SOURCE_DIR})

  target_include_directories(${TOOL_PROJECT_NAME}
    PUBLIC
      ${TOOL_PUBLIC_INCLUDES}
      ${CMAKE_SOURCE_DIR}/src
      ${CMAKE_SOURCE_DIR}/modules
    PRIVATE
      ${CMAKE_CURRENT_BINARY_DIR}/${TOOL_NAME})

  set_target_properties(${TOOL_PROJECT_NAME}
    PROPERTIES
      FOLDER
        "tools")

  if (UNIX)
    install(TARGETS ${TOOL_PROJECT_NAME} DESTINATION bin)
  elseif (WIN32)
    install(TARGETS ${TOOL_PROJECT_NAME} DESTINATION "${CMAKE_INSTALL_PREFIX}")
  endif()

  if (${TOOL_PROJECT_NAME} STREQUAL "mmaps_generator")
    if(WIN32)
      if("${CMAKE_MAKE_PROGRAM}" MATCHES "MSBuild")
        add_custom_command(TARGET ${TOOL_PROJECT_NAME}
          POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E copy_if_different "${SOURCE_TOOL_PATH}/mmaps-config.yaml" "${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/mmaps-config.yaml")
      elseif(MINGW)
        add_custom_command(TARGET ${TOOL_PROJECT_NAME}
          POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E copy_if_different "${SOURCE_TOOL_PATH}/mmaps-config.yaml" "${CMAKE_BINARY_DIR}/bin/mmaps-config.yaml")
      endif()
    endif()

    if (UNIX)
      install(FILES ${SOURCE_TOOL_PATH}/mmaps-config.yaml DESTINATION bin)
    elseif (WIN32)
      install(FILES ${SOURCE_TOOL_PATH}/mmaps-config.yaml DESTINATION "${CMAKE_INSTALL_PREFIX}")
    endif()
  endif()
endforeach()

# Copy config merger tool (if enabled) and if it's in TOOLS_BUILD=db-only + APPS_BUILD=none
if(TOOL_CONFIG_MERGER)
  if(WIN32)
    if("${CMAKE_MAKE_PROGRAM}" MATCHES "MSBuild")
      foreach(cfg IN ITEMS Debug Release RelWithDebInfo MinSizeRel)
        file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/bin/${cfg}/configs")
        file(COPY "${CMAKE_SOURCE_DIR}/apps/config-merger/python/" DESTINATION "${CMAKE_BINARY_DIR}/bin/${cfg}/configs")
      endforeach()
    elseif(MINGW)
      file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/bin/configs")
      file(COPY "${CMAKE_SOURCE_DIR}/apps/config-merger/python/" DESTINATION "${CMAKE_BINARY_DIR}/bin/configs")
    endif()
  elseif(UNIX)
    file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/bin/configs")
    file(COPY "${CMAKE_SOURCE_DIR}/apps/config-merger/python/" DESTINATION "${CMAKE_BINARY_DIR}/bin/configs")
  endif()
endif()
