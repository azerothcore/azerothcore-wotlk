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

if(POLICY CMP0167)
  cmake_policy(SET CMP0167 NEW)
endif()

if(WIN32)
  if(DEFINED ENV{Boost_ROOT})
    set(Boost_ROOT $ENV{Boost_ROOT})
  endif()

  set(Boost_USE_STATIC_LIBS        ON)
  set(Boost_USE_MULTITHREADED      ON)
  set(Boost_USE_STATIC_RUNTIME     OFF)
endif()

set(Boost_NO_WARN_NEW_VERSIONS ON)

include (CheckCXXSourceCompiles)

if (WIN32)
  # On windows the requirements are higher according to the wiki.
  set(BOOST_REQUIRED_VERSION 1.78)
else()
  set(BOOST_REQUIRED_VERSION 1.74)
endif()

# First get Boost + version without pulling any library components yet.
find_package(Boost ${BOOST_REQUIRED_VERSION} CONFIG REQUIRED COMPONENTS headers)

# Choose components depending on Boost version (string compare!)
if(Boost_VERSION VERSION_LESS "1.89.0")
  set(AC_BOOST_COMPONENTS system filesystem program_options iostreams regex)
else()
  # Boost.System is header-only in 1.89+; do not request 'system'.
  set(AC_BOOST_COMPONENTS filesystem program_options iostreams regex headers)
endif()

# Now request the actual components
find_package(Boost ${BOOST_REQUIRED_VERSION} CONFIG REQUIRED COMPONENTS ${AC_BOOST_COMPONENTS})


if(NOT Boost_FOUND)
  if(NOT DEFINED ENV{Boost_ROOT} AND NOT DEFINED Boost_DIR AND NOT DEFINED BOOST_ROOT AND NOT DEFINED BOOSTROOT)
    message(FATAL_ERROR "No Boost_ROOT environment variable could be found! Please make sure it is set and the points to your Boost installation.")
  endif()
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
