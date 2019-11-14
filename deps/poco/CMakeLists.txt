#
#
#

# Include POCO macros for group source
include(PocoMacros)

#
# Get source from Foundation
#

# Sources
file(GLOB SRCS_G "Foundation/src/*.cpp")
POCO_SOURCES_AUTO( SRCS ${SRCS_G})

# Headers
file(GLOB_RECURSE HDRS_G "Foundation/include/*.h" )
POCO_HEADERS_AUTO( SRCS ${HDRS_G})

# Platform Specific
POCO_SOURCES_AUTO_PLAT( SRCS UNIX Foundation/src/SyslogChannel.cpp )
POCO_HEADERS_AUTO( SRCS Foundation/include/Poco/SyslogChannel.h )

# For Windows CE we need to disable these
if(WINCE)
POCO_SOURCES_AUTO_PLAT( SRCS OFF
  Foundation/src/WindowsConsoleChannel.cpp
  Foundation/src/EventLogChannel.cpp
	)
else()
POCO_SOURCES_AUTO_PLAT( SRCS WIN32
	Foundation/src/WindowsConsoleChannel.cpp
	Foundation/src/EventLogChannel.cpp)
endif()

# Messages
POCO_MESSAGES( SRCS Logging Foundation/src/pocomsg.mc)

# pcre
POCO_SOURCES( SRCS pcre
  Foundation/src/pcre_config.c
  Foundation/src/pcre_byte_order.c
  Foundation/src/pcre_chartables.c
  Foundation/src/pcre_compile.c
  Foundation/src/pcre_exec.c
  Foundation/src/pcre_fullinfo.c
  Foundation/src/pcre_globals.c
  Foundation/src/pcre_maketables.c
  Foundation/src/pcre_newline.c
  Foundation/src/pcre_ord2utf8.c
  Foundation/src/pcre_study.c
  Foundation/src/pcre_tables.c
  Foundation/src/pcre_dfa_exec.c
  Foundation/src/pcre_get.c
  Foundation/src/pcre_jit_compile.c
  Foundation/src/pcre_refcount.c
  Foundation/src/pcre_string_utils.c
  Foundation/src/pcre_version.c
  Foundation/src/pcre_ucd.c
  Foundation/src/pcre_valid_utf8.c
  Foundation/src/pcre_xclass.c
)

# zlib
POCO_HEADERS( SRCS zlib
  Foundation/include/Poco/zconf.h
  Foundation/include/Poco/zlib.h)

POCO_SOURCES( SRCS zlib
  Foundation/src/adler32.c
  Foundation/src/compress.c
  Foundation/src/crc32.c
  Foundation/src/deflate.c
  Foundation/src/infback.c
  Foundation/src/inffast.c
  Foundation/src/inflate.c
  Foundation/src/inftrees.c
  Foundation/src/trees.c
  Foundation/src/zutil.c)

# Create static Library
add_library(Poco STATIC 
  ${SRCS})

target_link_libraries(Poco
PRIVATE
  acore-dependency-interface)

target_compile_definitions(Poco
  PUBLIC
    $<$<CONFIG:Debug>:_DEBUG>)

target_compile_features(Poco
  PUBLIC
    cxx_defaulted_move_initializers
    # cxx_std_14
    )
  
if(WIN32)
	target_compile_definitions(Poco PUBLIC POCO_OS_FAMILY_WINDOWS UNICODE _UNICODE)
	target_link_libraries(Poco PUBLIC iphlpapi)
endif()

# if (UNIX )
#   target_compile_definitions(Poco 
#     PUBLIC 
#       POCO_OS_FAMILY_UNIX)
  
#   if (APPLE)
#   target_compile_definitions(Poco 
#     PUBLIC 
#       POCO_HAVE_IPv6 
#       POCO_NO_STAT64)
  
#   target_link_libraries(Poco 
#     PUBLIC 
#       ${CMAKE_DL_LIBS})
#   else()
#   target_compile_definitions(Poco 
#     PUBLIC 
#       _REENTRANT 
#       _THREAD_SAFE 
#       _LARGEFILE64_SOURCE 
#       _FILE_OFFSET_BITS=64)

#   target_compile_definitions(Poco 
#     PUBLIC
#       _XOPEN_SOURCE=500
#       POCO_HAVE_FD_EPOLL)

#   target_link_libraries(Poco
#    PUBLIC 
#     pthread 
#     ${CMAKE_DL_LIBS} 
#     rt)
#   endif(APPLE)
# endif(UNIX)

if(CMAKE_COMPILER_IS_MINGW)
  target_compile_definitions(Poco
	  PUBLIC
      WC_NO_BEST_FIT_CHARS=0x400
      POCO_WIN32_UTF8
      _WIN32
      MINGW32
      WINVER=0x500
      ODBCVER=0x0300
      POCO_THREAD_STACK_SIZE)
endif()

target_include_directories(Poco
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/Foundation/include
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Foundation/src)

target_compile_definitions(Poco
  PUBLIC
    POCO_STATIC)

if (MINGW)
  target_compile_definitions(Poco
    PUBLIC
      WC_NO_BEST_FIT_CHARS=0x400
      _WIN32
      MINGW32
      WINVER=0x500
      ODBCVER=0x0300
      POCO_THREAD_STACK_SIZE)
endif()

set_target_properties(Poco PROPERTIES LINKER_LANGUAGE CXX)
