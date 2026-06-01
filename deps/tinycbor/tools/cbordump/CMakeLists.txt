# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: MIT
if(NOT WIN32)
  tinycbor_add_executable(cbordump cbordump.c)
  install(TARGETS cbordump)
endif()
