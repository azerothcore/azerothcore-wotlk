GetEverdawnToolsList(EVERDAWN_TOOLS_BUILD_LIST)

# Display the graphs
message("")
message("* Everdawn Tools build list:")
message("  |  tools:")

foreach(TOOL_BUILD_GRAPH_KEY ${EVERDAWN_TOOLS_BUILD_LIST})
  message("  |   +- ${TOOL_BUILD_GRAPH_KEY}")
endforeach()

message("")

find_package(wxWidgets QUIET)
if(NOT wxWidgets_FOUND)
    return()
endif()

include(${wxWidgets_USE_FILE})

if(NOT TARGET database)
    message("Database target not found, adding it")
    add_subdirectory(${CMAKE_SOURCE_DIR}/src/server/database deps/acore-database)
endif()

foreach(EVERDAWN_TOOL_LIBRARY ${EVERDAWN_TOOLS_LIBRARIES})
    set(EVERDAWN_TOOL_LIBRARY_NAME "everdawn_${EVERDAWN_TOOL_LIBRARY}")
    message("Creating tool library ${EVERDAWN_TOOL_LIBRARY_NAME}")
    GetPathToEverdawnTool(${EVERDAWN_TOOL_LIBRARY} EVERDAWN_SOURCE_TOOL_LIBRARY_PATH)
    CollectSourceFiles(
        ${EVERDAWN_SOURCE_TOOL_LIBRARY_PATH}
        EVERDAWN_TOOL_LIBRARY_SOURCES)
    add_library(${EVERDAWN_TOOL_LIBRARY_NAME} INTERFACE ${EVERDAWN_TOOL_LIBRARY_SOURCES})
endforeach()

GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

foreach(EVERDAWN_TOOL_NAME ${EVERDAWN_TOOLS_BUILD_LIST})

    set(EVERDAWN_TOOL_PROJECT_NAME ${EVERDAWN_TOOL_NAME})

    message("Generating project for tool ${EVERDAWN_TOOL_PROJECT_NAME}")

    GetPathToEverdawnTool(${EVERDAWN_TOOL_NAME} EVERDAWN_SOURCE_TOOL_PATH)

    unset(EVERDAWN_TOOL_PRIVATE_SOURCES)
    CollectSourceFiles(
        ${EVERDAWN_SOURCE_TOOL_PATH}
        EVERDAWN_TOOL_PRIVATE_SOURCES)

    if(APPLE)
       add_executable(${EVERDAWN_TOOL_PROJECT_NAME} MACOSX_BUNDLE ${EVERDAWN_TOOL_PRIVATE_SOURCES})
    else()
       add_executable(${EVERDAWN_TOOL_PROJECT_NAME} WIN32 ${EVERDAWN_TOOL_PRIVATE_SOURCES})
    endif()

    list(APPEND EVERDAWN_TOOLS_LIBS boost database ${wxWidgets_LIBRARIES})

    if(${EVERDAWN_TOOL_PROJECT_NAME} MATCHES "instance_creator")
        target_include_directories(${EVERDAWN_TOOL_PROJECT_NAME}
        SYSTEM
        PUBLIC
            database
        )

        target_link_libraries(${EVERDAWN_TOOL_PROJECT_NAME}
            PUBLIC
                database
        )
    endif()

     target_include_directories(${EVERDAWN_TOOL_PROJECT_NAME}
        SYSTEM
        PUBLIC
            everdawn_common
        PRIVATE
            ${wxWidgets_LIBRARIES}
     )

        target_link_libraries(${EVERDAWN_TOOL_PROJECT_NAME}
            PUBLIC
                everdawn_common
            PRIVATE
                ${wxWidgets_LIBRARIES}
        )

    unset(EVERDAWN_TOOL_PUBLIC_INCLUDES)
    CollectIncludeDirectories(
      ${EVERDAWN_SOURCE_TOOL_PATH}
      EVERDAWN_TOOL_PUBLIC_INCLUDES)

    target_include_directories(${EVERDAWN_TOOL_PROJECT_NAME}
    PUBLIC
      ${CMAKE_CURRENT_SOURCE_DIR})

    target_include_directories(${EVERDAWN_TOOL_PROJECT_NAME}
      PUBLIC
        ${EVERDAWN_TOOL_PUBLIC_INCLUDES}
      PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}/${EVERDAWN_TOOL_NAME})

    unset(EVERDAWN_TOOLS_RESOURCES)
    file(GLOB EVERDAWN_TOOLS_RESOURCES
      "${CMAKE_CURRENT_SOURCE_DIR}/Resources/*"
    )
    file(COPY ${EVERDAWN_TOOLS_RESOURCES} DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/Resources)

    set_target_properties(${EVERDAWN_TOOL_PROJECT_NAME}
      PROPERTIES
        FOLDER
          "tools")

    get_target_property(defs ${EVERDAWN_TOOL_PROJECT_NAME} COMPILE_DEFINITIONS)

    if (UNIX)
        # Buggy visual studio 2022 cmake intelisense
        # list(FILTER defs EXCLUDE REGEX [[^_WIN32$]])
        # list(FILTER defs EXCLUDE REGEX [[^__WIN32__$]])
        # list(FILTER defs EXCLUDE REGEX [[^__WXMSW__$]])
        install(TARGETS ${EVERDAWN_TOOL_PROJECT_NAME} DESTINATION bin)
    elseif (WIN32)
        install(TARGETS ${EVERDAWN_TOOL_PROJECT_NAME} DESTINATION "${CMAKE_INSTALL_PREFIX}")
    endif()

    set_property(TARGET ${EVERDAWN_TOOL_PROJECT_NAME} PROPERTY COMPILE_DEFINITIONS ${defs})
endforeach()
