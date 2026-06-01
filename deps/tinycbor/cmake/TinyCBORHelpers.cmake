# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: MIT
function(tinycbor_add_executable target)
  add_executable(${target} ${ARGN})
  target_link_libraries(${target} tinycbor)
  target_compile_options(${target} PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:-W3>
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra>
  )
endfunction()

function(tinycbor_add_test target)
  tinycbor_add_executable(${target} ${ARGN})
  set(memcheck_command ${CMAKE_MEMORYCHECK_COMMAND} ${CMAKE_MEMORYCHECK_COMMAND_OPTIONS})
  separate_arguments(memcheck_command)
  add_test(NAME ${target} COMMAND ${memcheck_command} $<TARGET_FILE:${target}>)
endfunction()

function(tinycbor_add_qtest target)
  tinycbor_add_test(${target} ${ARGN})
  target_link_libraries(${target} Qt::Core Qt::Test)
endfunction()

option(WITH_VALGRIND "Use Valgrind (if found) to run tests" ON)
if(WITH_VALGRIND AND NOT DEFINED CMAKE_MEMORYCHECK_COMMAND)
  find_program(VALGRIND "valgrind")
  if(VALGRIND)
    set(CMAKE_MEMORYCHECK_COMMAND ${VALGRIND} --tool=memcheck)
    set(CMAKE_MEMORYCHECK_COMMAND_OPTIONS}
        --error-exitcode=255
        --errors-for-leak-kinds=definite
        --leak-check=yes
        --num-callers=20
    )
  endif()
else()
  set(VALGRIND OFF)
endif()
