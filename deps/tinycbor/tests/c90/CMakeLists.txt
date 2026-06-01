# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: MIT
tinycbor_add_test(tst_c90 tst_c90.c)
set_target_properties(tst_c90 PROPERTIES
  LINKER_LANGUAGE C
  C_STANDARD 90
  C_STANDARD_REQUIRED ON
)
