# Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

if(WIN32)
 set(BOOST_DEBUG ON)
  if(DEFINED ENV{BOOST_ROOT})
    set(BOOST_ROOT $ENV{BOOST_ROOT})
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 19.0)
      set(BOOST_LIBRARYDIR ${BOOST_ROOT}/lib${PLATFORM}-msvc-12.0)
    else()
      if (CMAKE_CXX_COMPILER_VERSION VERSION_LESS 19.10)
        set(BOOST_LIBRARYDIR ${BOOST_ROOT}/lib${PLATFORM}-msvc-14.0)
      else()
        list(APPEND BOOST_LIBRARYDIR
          ${BOOST_ROOT}/lib${PLATFORM}-msvc-14.1
          ${BOOST_ROOT}/lib${PLATFORM}-msvc-14.0 )
      endif()
    endif()
  else()
    message(FATAL_ERROR "No BOOST_ROOT environment variable could be found! Please make sure it is set and the points to your Boost installation.")
  endif()

  set(Boost_USE_STATIC_LIBS        ON)
  set(Boost_USE_MULTITHREADED      ON)
  set(Boost_USE_STATIC_RUNTIME     OFF)
endif()

if (WIN32)
  # On windows the requirements are higher according to the wiki.
  set(BOOST_REQUIRED_VERSION 1.59)
else()
  set(BOOST_REQUIRED_VERSION 1.58)
endif()

find_package(Boost ${BOOST_REQUIRED_VERSION} REQUIRED system filesystem thread program_options iostreams regex)

if(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
endif()