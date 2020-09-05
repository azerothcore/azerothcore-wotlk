CollectSourceFiles(
        ${CMAKE_CURRENT_SOURCE_DIR}
        PRIVATE_SOURCES
)

add_executable(
        unit_tests
        ${PRIVATE_SOURCES}
)

target_link_libraries(
        unit_tests
        game
        gtest_main
        game-interface
)

add_test(
        NAME
        unit
        COMMAND
        ${CMAKE_BINARY_DIR}/src/test/unit_tests
)
