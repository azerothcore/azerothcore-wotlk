find_package(wxWidgets QUIET)
if(NOT wxWidgets_FOUND)
    return()
endif()

include(${wxWidgets_USE_FILE})

list(APPEND EVERDAWN_TOOLS_BUILD_LIST "instance_creator" "realm_manager")

if(NOT TARGET database)
    message("Database target not found, adding it")
    add_subdirectory(${CMAKE_SOURCE_DIR}/src/server/database deps/acore-database)
endif()

foreach(EVERDAWN_TOOL_NAME ${EVERDAWN_TOOLS_BUILD_LIST})

    set(EVERDAWN_TOOL_PROJECT_NAME ${EVERDAWN_TOOL_NAME})

    message("Generating project for tool ${EVERDAWN_TOOL_PROJECT_NAME}")

    GetPathToEverdawnTool(${EVERDAWN_TOOL_NAME} EVERDAWN_SOURCE_TOOL_PATH)

    unset(TOOL_PRIVATE_SOURCES)
    CollectSourceFiles(
        ${EVERDAWN_SOURCE_TOOL_PATH}
        EVERDAWN_TOOL_PRIVATE_SOURCES)

    if(APPLE)
       add_executable(${EVERDAWN_TOOL_PROJECT_NAME} MACOSX_BUNDLE ${EVERDAWN_TOOL_PRIVATE_SOURCES})
    else()
       add_executable(${EVERDAWN_TOOL_PROJECT_NAME} WIN32 ${EVERDAWN_TOOL_PRIVATE_SOURCES})
    endif()

    target_link_libraries(${EVERDAWN_TOOL_PROJECT_NAME}
        PUBLIC
            boost
            database
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

    set_target_properties(${EVERDAWN_TOOL_PROJECT_NAME}
      PROPERTIES
        FOLDER
          "tools")

    install(TARGETS ${EVERDAWN_TOOL_PROJECT_NAME} DESTINATION bin)
endforeach()
