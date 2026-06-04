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

  # Boost 1.81 maps vc143 only up to MSVC_VERSION 1939; MSVC 19.40-19.49 (VS 2022 17.10+)
  # is ABI-compatible with vc143 but unrecognised by BoostDetectToolset-1.81.0.cmake.
  # Pre-set both variables: Boost_COMPILER controls variant selection; BOOST_DETECTED_TOOLSET
  # prevents the "toolset is unknown" message (the detect file does not reset it, only assigns
  # it on a matched branch, so our value survives the include when no branch fires).
  if(MSVC AND MSVC_VERSION GREATER_EQUAL 1940 AND MSVC_VERSION LESS 1950)
    if(NOT DEFINED Boost_COMPILER)
      set(Boost_COMPILER "vc143")
    endif()
    set(BOOST_DETECTED_TOOLSET "vc143")
  endif()
endif()

set(Boost_NO_WARN_NEW_VERSIONS ON)

include (CheckCXXSourceCompiles)

if (WIN32)
  # On windows the requirements are higher according to the wiki.
  set(BOOST_REQUIRED_VERSION 1.78)
else()
  set(BOOST_REQUIRED_VERSION 1.74)
endif()

if (POLICY CMP0167)
  cmake_policy(SET CMP0167 NEW)
  # Windows pre-built Boost binaries place cmake config files under lib<arch>-msvc-<ver>/cmake/
  # which is not in CMake's standard config-mode search path; auto-discover and set Boost_DIR.
  if (WIN32 AND NOT DEFINED Boost_DIR)
    set(_boost_hint "")
    if (DEFINED Boost_ROOT)
      set(_boost_hint "${Boost_ROOT}")
    elseif (DEFINED ENV{Boost_ROOT})
      set(_boost_hint "$ENV{Boost_ROOT}")
    elseif (DEFINED ENV{BOOST_ROOT})
      set(_boost_hint "$ENV{BOOST_ROOT}")
    endif()
    if (_boost_hint)
      file(GLOB _boost_cmake_dirs "${_boost_hint}/lib*/cmake/Boost-*")
      if (_boost_cmake_dirs)
        list(GET _boost_cmake_dirs 0 Boost_DIR)
      endif()
      unset(_boost_cmake_dirs)
    endif()
    unset(_boost_hint)
  endif()
endif()

# Boost.System is header-only since 1.69; do not require it explicitly.
find_package(Boost ${BOOST_REQUIRED_VERSION} REQUIRED COMPONENTS filesystem program_options iostreams regex)

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
