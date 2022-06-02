#
# This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

# An interface library to make the target com available to other targets
add_library(acore-compile-option-interface INTERFACE)

# Use -std=c++11 instead of -std=gnu++11
set(CXX_EXTENSIONS OFF)

# Enable C++20 support
set(CMAKE_CXX_STANDARD 20)
message(STATUS "Enabled С++20 standard")

# An interface library to make the warnings level available to other targets
# This interface taget is set-up through the platform specific script
add_library(acore-warning-interface INTERFACE)

# An interface used for all other interfaces
add_library(acore-default-interface INTERFACE)

target_link_libraries(acore-default-interface
  INTERFACE
    acore-compile-option-interface)

# An interface used for silencing all warnings
add_library(acore-no-warning-interface INTERFACE)

if (MSVC)
  target_compile_options(acore-no-warning-interface
    INTERFACE
      /W0)
else()
  target_compile_options(acore-no-warning-interface
    INTERFACE
      -w)
endif()

# An interface library to change the default behaviour
# to hide symbols automatically.
add_library(acore-hidden-symbols-interface INTERFACE)

# An interface amalgamation which provides the flags and definitions
# used by the dependency targets.
add_library(acore-dependency-interface INTERFACE)
target_link_libraries(acore-dependency-interface
  INTERFACE
    acore-default-interface
    acore-no-warning-interface
    acore-hidden-symbols-interface)

# An interface amalgamation which provides the flags and definitions
# used by the core targets.
add_library(acore-core-interface INTERFACE)
target_link_libraries(acore-core-interface
  INTERFACE
    acore-default-interface
    acore-warning-interface)
