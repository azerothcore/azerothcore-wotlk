find_package(wxWidgets QUIET)
if(NOT wxWidgets_FOUND)
    return()
endif()

include(${wxWidgets_USE_FILE})

list(APPEND EVERDAWN_TOOLS_BUILD_LIST "instance_creator" "realm_manager")

foreach(EVERDAWN_TOOL_NAME ${EVERDAWN_TOOLS_BUILD_LIST})
    set(EVERDAWN_TOOL_PROJECT_NAME ${EVERDAWN_TOOL_NAME})
    set(EVERDAWN_TOOL_PRIVATE_SOURCES ${EVERDAWN_TOOL_NAME}/main.cpp)

    message("Generating project for tool ${EVERDAWN_TOOL_PROJECT_NAME}")

    if(APPLE)
       add_executable(${EVERDAWN_TOOL_PROJECT_NAME} MACOSX_BUNDLE ${EVERDAWN_TOOL_PRIVATE_SOURCES})
    else()
       add_executable(${EVERDAWN_TOOL_PROJECT_NAME} WIN32 ${EVERDAWN_TOOL_PRIVATE_SOURCES})
    endif()

    target_link_libraries(${EVERDAWN_TOOL_PROJECT_NAME} PRIVATE ${wxWidgets_LIBRARIES})

    install(TARGETS ${EVERDAWN_TOOL_PROJECT_NAME} DESTINATION bin)
endforeach()
