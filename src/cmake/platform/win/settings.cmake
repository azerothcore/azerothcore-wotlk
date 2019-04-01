# Platform-specfic options
option(USE_MYSQL_SOURCES "Use included MySQL-sources to build libraries" 0)

# Package overloads
set(ACE_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/deps/acelite)
set(ACE_LIBRARY "ace")

if( USE_MYSQL_SOURCES )
  set(MYSQL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/deps/mysqllite/include)
  set(MYSQL_LIBRARY "libmysql")
  set( MYSQL_FOUND 1 )
  message(STATUS "Using supplied MySQL sources")
endif()

# check the CMake preload parameters (commented out by default)

# overload CMAKE_INSTALL_PREFIX if not being set properly
#if( WIN32 )
#  if( NOT CYGWIN )
#    if( NOT CMAKE_INSTALL_PREFIX )
#      set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/bin")
#    endif()
#  endif()
#endif()

if ( MSVC )
  include(${CMAKE_SOURCE_DIR}/src/cmake/compiler/msvc/settings.cmake)
elseif ( MINGW )
  include(${CMAKE_SOURCE_DIR}/src/cmake/compiler/mingw/settings.cmake)
endif()
