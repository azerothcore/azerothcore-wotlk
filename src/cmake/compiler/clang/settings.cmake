#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
# Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
#

# Set build-directive (used in core to tell which buildtype we used)
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -D_BUILD_DIRECTIVE="${CMAKE_BUILD_TYPE}")

# This tests for a bug in clang-7 that causes linkage to fail for 64-bit from_chars (in some configurations)
# If the clang requirement is bumped to >= clang-8, you can remove this check, as well as
# the associated ifdef block in src/common/Utilities/StringConvert.h
include(CheckCXXSourceCompiles)

check_cxx_source_compiles("
#include <charconv>
#include <cstdint>
int main()
{
    uint64_t n;
    char const c[] = \"0\";
    std::from_chars(c, c+1, n);
    return static_cast<int>(n);
}
" CLANG_HAVE_PROPER_CHARCONV)

if (NOT CLANG_HAVE_PROPER_CHARCONV)
  message(STATUS "Clang: Detected from_chars bug for 64-bit integers, workaround enabled")
  target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -DACORE_NEED_CHARCONV_WORKAROUND)
endif()

if(WITH_WARNINGS)
  target_compile_options(acore-warning-interface
    INTERFACE
      -W
      -Wall
      -Wextra
      -Winit-self
      -Wfatal-errors
      -Wno-mismatched-tags
      -Woverloaded-virtual)
  message(STATUS "Clang: All warnings enabled")
endif()

if(WITH_COREDEBUG)
  target_compile_options(acore-compile-option-interface
    INTERFACE
      -g3)
  message(STATUS "Clang: Debug-flags set (-g3)")
endif()

# -Wno-narrowing needed to suppress a warning in g3d
# -Wno-deprecated-register is needed to suppress gsoap warnings on Unix systems.
target_compile_options(acore-compile-option-interface
  INTERFACE
    -Wno-narrowing
    -Wno-deprecated-register)

target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -DDEBUG=1)
