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

if(WIN32)
  if(DEFINED ENV{Boost_ROOT})
    set(Boost_ROOT $ENV{Boost_ROOT})
  endif()

  set(Boost_USE_STATIC_LIBS        ON)
  set(Boost_USE_MULTITHREADED      ON)
  set(Boost_USE_STATIC_RUNTIME     OFF)
endif()

set(Boost_NO_WARN_NEW_VERSIONS ON)


# Set CMake policy to allow FindBoost (for Homebrew/macOS compatibility)
if(POLICY CMP0167)
  cmake_policy(SET CMP0167 OLD)
endif()

include(CheckCXXSourceCompiles)


if (WIN32)
  # On windows the requirements are higher according to the wiki.
  set(BOOST_REQUIRED_VERSION 1.78)
elseif(APPLE)
  set(BOOST_REQUIRED_VERSION 1.74)
  set(Boost_NO_BOOST_CMAKE ON)
  # Help CMake find Homebrew Boost installation
  set(BOOST_ROOT "/opt/homebrew" CACHE PATH "Homebrew Boost root")
  set(Boost_LIBRARY_DIR "/opt/homebrew/lib" CACHE PATH "Homebrew Boost library dir")
  set(Boost_INCLUDE_DIR "/opt/homebrew/include" CACHE PATH "Homebrew Boost include dir")
else()
  set(BOOST_REQUIRED_VERSION 1.74)
endif()


# Use classic FindBoost module for better compatibility with Homebrew/macOS
find_package(Boost ${BOOST_REQUIRED_VERSION} REQUIRED COMPONENTS system filesystem program_options iostreams regex)

if(NOT Boost_FOUND)
  message(FATAL_ERROR "Boost not found! On macOS, ensure you have installed boost via Homebrew (brew install boost) and that CMake can find it. You may need to set CMAKE_PREFIX_PATH or Boost_ROOT.")
endif()

add_library(boost INTERFACE)

target_link_libraries(boost
  INTERFACE
    ${Boost_LIBRARIES})

target_include_directories(boost
  INTERFACE
    ${Boost_INCLUDE_DIRS})

target_compile_definitions(boost
  INTERFACE
    -DBOOST_DATE_TIME_NO_LIB
    -DBOOST_REGEX_NO_LIB
    -DBOOST_CHRONO_NO_LIB
    -DBOOST_SERIALIZATION_NO_LIB
    -DBOOST_CONFIG_SUPPRESS_OUTDATED_MESSAGE
    -DBOOST_ASIO_NO_DEPRECATED
    -DBOOST_SYSTEM_USE_UTF8
    -DBOOST_BIND_NO_PLACEHOLDERS)
