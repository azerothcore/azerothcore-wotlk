# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: MIT
include(FindPkgConfig)
pkg_check_modules(LIBCJSON libcjson)
if(LIBCJSON_FOUND)
  tinycbor_add_executable(json2cbor json2cbor.c)
  target_include_directories(json2cbor SYSTEM PUBLIC ${LIBCJSON_INCLUDE_DIRS})
  target_link_libraries(json2cbor ${LIBCJSON_LIBRARIES})
endif()
