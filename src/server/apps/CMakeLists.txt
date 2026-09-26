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

# Make the script module list available in the current scope
GetApplicationsList(APPLICATIONS_BUILD_LIST)

if (APPS_BUILD STREQUAL "none")
  set(APPS_DEFAULT_BUILD "disabled")
else()
  set(APPS_DEFAULT_BUILD "enabled")
endif()

# Sets BUILD_APPS_USE_WHITELIST
# Sets BUILD_APPS_WHITELIST
if (APPS_BUILD MATCHES "-only")
  set(BUILD_APPS_USE_WHITELIST ON)

  if (APPS_BUILD STREQUAL "auth-only")
    list(APPEND BUILD_APPS_WHITELIST authserver)
  endif()

  if (APPS_BUILD STREQUAL "world-only")
    list(APPEND BUILD_APPS_WHITELIST worldserver)
  endif()
endif()

# Set the SCRIPTS_${BUILD_APP} variables from the
# variables set above
foreach(BUILD_APP ${APPLICATIONS_BUILD_LIST})
  ApplicationNameToVariable(${BUILD_APP} BUILD_APP_VARIABLE)

  if(${BUILD_APP_VARIABLE} STREQUAL "default")
    if(BUILD_APPS_USE_WHITELIST)
      list(FIND BUILD_APPS_WHITELIST "${BUILD_APP}" INDEX)
      if(${INDEX} GREATER -1)
        set(${BUILD_APP_VARIABLE} ${APPS_DEFAULT_BUILD})
      else()
        set(${BUILD_APP_VARIABLE} "disabled")
      endif()
    else()
      set(${BUILD_APP_VARIABLE} ${APPS_DEFAULT_BUILD})
    endif()
  endif()

  # Build the Graph values
  if(${BUILD_APP_VARIABLE} MATCHES "enabled")
    list(APPEND BUILD_APP_GRAPH_KEYS apps)
    set(BUILD_APP_VALUE_DISPLAY_apps apps)
    list(APPEND BUILD_APP_VALUE_CONTAINS_apps ${BUILD_APP})

  else()
    list(APPEND BUILD_APP_GRAPH_KEYS disabled)
    set(BUILD_APP_VALUE_DISPLAY_disabled disabled)
    list(APPEND BUILD_APP_VALUE_CONTAINS_disabled ${BUILD_APP})
  endif()
endforeach()

list(SORT BUILD_APP_GRAPH_KEYS)
list(REMOVE_DUPLICATES BUILD_APP_GRAPH_KEYS)

# Display the graphs
message("")
message("* Apps build list (${APPS_BUILD}):")
message("  |")

foreach(BUILD_APP_GRAPH_KEY ${BUILD_APP_GRAPH_KEYS})
  if(NOT BUILD_APP_GRAPH_KEY STREQUAL "disabled")
    message("  +- ${BUILD_APP_VALUE_DISPLAY_${BUILD_APP_GRAPH_KEY}}")
  else()
    message("  |  ${BUILD_APP_VALUE_DISPLAY_${BUILD_APP_GRAPH_KEY}}")
  endif()
  foreach(BUILD_APP_GRAPH_ENTRY ${BUILD_APP_VALUE_CONTAINS_${BUILD_APP_GRAPH_KEY}})
    message("  |   +- ${BUILD_APP_GRAPH_ENTRY}")
  endforeach()
  message("  |")
endforeach()

message("")

GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

# Generates the actual apps projects
foreach(APPLICATION_NAME ${APPLICATIONS_BUILD_LIST})
  GetPathToApplication(${APPLICATION_NAME} SOURCE_APP_PATH)
  ApplicationNameToVariable(${APPLICATION_NAME} BUILD_APP_VARIABLE)

  if (${BUILD_APP_VARIABLE} STREQUAL "disabled")
    continue()
  endif()

  unset(APP_PRIVATE_SOURCES)
  CollectSourceFiles(
    ${SOURCE_APP_PATH}
    APP_PRIVATE_SOURCES
    # Exclude
    ${SOURCE_APP_PATH}/PrecompiledHeaders)

  if (WIN32)
    list(APPEND APP_PRIVATE_SOURCES ${winDebugging})

    if (${APPLICATION_NAME} MATCHES "worldserver")
      list(APPEND APP_PRIVATE_SOURCES ${winService})
    endif()

    if (MSVC)
      list(APPEND APP_PRIVATE_SOURCES ${SOURCE_APP_PATH}/${APPLICATION_NAME}.rc)
    endif()
  endif()

  GetProjectNameOfApplicationName(${APPLICATION_NAME} APP_PROJECT_NAME)

  # Create the application project
  add_executable(${APP_PROJECT_NAME}
    ${APP_PRIVATE_SOURCES})

  add_dependencies(${APP_PROJECT_NAME} revision.h)

  target_link_libraries(${APP_PROJECT_NAME}
    PRIVATE
      acore-core-interface)

  if (${APP_PROJECT_NAME} MATCHES "authserver")
    target_link_libraries(${APP_PROJECT_NAME}
      PUBLIC
        shared)
  elseif(${APP_PROJECT_NAME} MATCHES "worldserver")
    target_link_libraries(${APP_PROJECT_NAME}
      PUBLIC
        modules
        scripts
        game
        gsoap
        readline
        gperftools
        libsidecar)

    if (UNIX AND NOT NOJEM)
      set(${APP_PROJECT_NAME}_LINK_FLAGS "-pthread -lncurses ${${APP_PROJECT_NAME}_LINK_FLAGS}")
    endif()

    set_target_properties(${APP_PROJECT_NAME} PROPERTIES LINK_FLAGS "${${APP_PROJECT_NAME}_LINK_FLAGS}")

    # Real libsidecar runtime location (not via imported-target INTERFACE -rpath:
    # game, scripts, and worldserver all link libsidecar and would get duplicates).
    #
    # UNIX/macOS — rpath search order:
    #   BUILD:  deps/libsidecar → next to binary → ../lib
    #   INSTALL: target inherits CMAKE_INSTALL_RPATH (${prefix}/lib) first, then
    #            APPEND next to binary and ../lib (no source-tree path)
    #
    # Windows — no rpath; loader only searches the exe directory (then PATH).
    #   BUILD:  POST_BUILD copy DLL next to worldserver
    #   INSTALL: install(FILES) places DLL next to worldserver (see deps/libsidecar)
    if (USE_REAL_LIBSIDECAR)
      if (WIN32 AND LIBSIDECAR_SHARED_FILE)
        add_custom_command(TARGET ${APP_PROJECT_NAME} POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${LIBSIDECAR_SHARED_FILE}"
            "$<TARGET_FILE_DIR:${APP_PROJECT_NAME}>"
          COMMENT "Copy libsidecar.dll next to worldserver (Windows build tree)")
      elseif (LIBSIDECAR_RUNTIME_DIR)
        if (APPLE)
          set_property(TARGET ${APP_PROJECT_NAME} APPEND PROPERTY BUILD_RPATH
            "${LIBSIDECAR_RUNTIME_DIR}"
            "@loader_path"
            "@loader_path/../lib")
          set_property(TARGET ${APP_PROJECT_NAME} APPEND PROPERTY INSTALL_RPATH
            "@loader_path"
            "@loader_path/../lib")
        elseif (UNIX)
          set_property(TARGET ${APP_PROJECT_NAME} APPEND PROPERTY BUILD_RPATH
            "${LIBSIDECAR_RUNTIME_DIR}"
            "$ORIGIN"
            "$ORIGIN/../lib")
          set_property(TARGET ${APP_PROJECT_NAME} APPEND PROPERTY INSTALL_RPATH
            "$ORIGIN"
            "$ORIGIN/../lib")
        endif()
      endif()
    endif()

    # Add all dynamic projects as dependency to the worldserver
    if (WORLDSERVER_DYNAMIC_SCRIPT_MODULES_DEPENDENCIES)
      add_dependencies(${APP_PROJECT_NAME} ${WORLDSERVER_DYNAMIC_SCRIPT_MODULES_DEPENDENCIES})
    endif()
   endif()

  unset(APP_PUBLIC_INCLUDES)
  CollectIncludeDirectories(
    ${SOURCE_APP_PATH}
    APP_PUBLIC_INCLUDES
    # Exclude
    ${SOURCE_APP_PATH}/PrecompiledHeaders)

  target_include_directories(${APP_PROJECT_NAME}
    PUBLIC
      ${CMAKE_CURRENT_SOURCE_DIR})

  target_include_directories(${APP_PROJECT_NAME}
    PUBLIC
      ${APP_PUBLIC_INCLUDES}
    PRIVATE
      ${CMAKE_CURRENT_BINARY_DIR}/${APPLICATION_NAME})

  set_target_properties(${APP_PROJECT_NAME}
    PROPERTIES
      FOLDER
        "server")

  # Install config
  CopyApplicationConfig(${APP_PROJECT_NAME} ${APPLICATION_NAME})

# Copy config merger tool (only once, after all app targets, if enabled)

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

  if (UNIX)
    install(TARGETS ${APP_PROJECT_NAME} DESTINATION bin)
  elseif (WIN32)
    install(TARGETS ${APP_PROJECT_NAME} DESTINATION "${CMAKE_INSTALL_PREFIX}")
  endif()

  set(PATH_TO_PCH ${SOURCE_APP_PATH}/PrecompiledHeaders/${APPLICATION_NAME}PCH.h)

  # Generate precompiled header
  if (USE_COREPCH AND EXISTS ${PATH_TO_PCH})
    add_cxx_pch(${APP_PROJECT_NAME} ${PATH_TO_PCH})
  endif()
endforeach()
