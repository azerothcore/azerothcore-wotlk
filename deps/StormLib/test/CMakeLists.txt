cmake_minimum_required(VERSION 3.25)

set(TEST_SRC_FILES
        StormTest.cpp
)

# Option to use the legacy hardcoded paths
option(STORMTEST_USE_OLD_PATHS "Use hardcoded OS-specific default paths for WORK_PATH_ROOT" ON)

if(NOT STORMTEST_USE_OLD_PATHS)
    set(WORK_PATH_ROOT "${CMAKE_CURRENT_BINARY_DIR}/work")
    add_compile_definitions(WORK_PATH_ROOT="${WORK_PATH_ROOT}")
endif()

find_package(ALSA REQUIRED)
add_executable(StormLib_test ${TEST_SRC_FILES})
target_link_libraries(StormLib_test storm ALSA::ALSA)
install(TARGETS StormLib_test RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

add_test(NAME StormLib_test COMMAND StormLib_test)
