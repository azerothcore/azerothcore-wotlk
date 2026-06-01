# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: MIT
include(TinyCBORHelpers)
add_subdirectory(c90)

if(WITH_FREESTANDING OR NOT WITH_FLOATING_POINT)
  return()
endif()

find_package(Qt6 COMPONENTS Core Test)
if(Qt6_FOUND)
  set(CMAKE_CXX_STANDARD 20)
  set(CMAKE_AUTOMOC ON)
  add_subdirectory(cpp)
  add_subdirectory(encoder)
  add_subdirectory(parser)
  if(WITH_CBOR2JSON)
    add_subdirectory(tojson)
  endif()
endif()
