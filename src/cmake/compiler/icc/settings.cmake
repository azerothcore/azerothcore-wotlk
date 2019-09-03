#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
# Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
#

# Set build-directive (used in core to tell which buildtype we used)
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -D_BUILD_DIRECTIVE="${CMAKE_BUILD_TYPE}")

if(PLATFORM EQUAL 32)
  target_compile_options(acore-compile-option-interface
    INTERFACE
      -axSSE2)
else()
  target_compile_options(acore-compile-option-interface
    INTERFACE
      -xSSE2)
endif()

if(WITH_WARNINGS)
  target_compile_options(acore-warning-interface
    INTERFACE
      -w1)
  message(STATUS "ICC: All warnings enabled")
endif()

if(WITH_COREDEBUG)
  target_compile_options(acore-compile-option-interface
    INTERFACE
      -g)
  message(STATUS "ICC: Debug-flag set (-g)")
endif()
