#
#
#

# Include POCO macros for group source
include(PocoSourceMacros)

#
# Get source from Foundation
#

# Sources Foundation
file(GLOB SRCS_G "Foundation/src/*.cpp")
POCO_SOURCES_AUTO( SRCS ${SRCS_G})

# Headers Foundation
file(GLOB_RECURSE HDRS_G "Foundation/include/*.h" )
POCO_HEADERS_AUTO( SRCS ${HDRS_G})

# Platform Specific
POCO_SOURCES_AUTO_PLAT( SRCS UNIX Foundation/src/SyslogChannel.cpp )
POCO_HEADERS_AUTO( SRCS Foundation/include/Poco/SyslogChannel.h )

# For Windows CE we need to disable these
POCO_SOURCES_AUTO_PLAT( SRCS WIN32
  Foundation/src/WindowsConsoleChannel.cpp
  Foundation/src/EventLogChannel.cpp)

POCO_SOURCES(SRCS pcre
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
POCO_HEADERS(SRCS zlib
  Foundation/include/Poco/zconf.h
  Foundation/include/Poco/zlib.h
)

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
  Foundation/src/zutil.c
)

#
# Get source from Util
#

# # Sources Util
# file(GLOB SRCS_G "Util/src/*.cpp")
# POCO_SOURCES_AUTO( SRCS ${SRCS_G})

# # Headers Util
# file(GLOB_RECURSE HDRS_G "Util/include/*.h" )
# POCO_HEADERS_AUTO( SRCS ${HDRS_G})

# POCO_SOURCES_AUTO_PLAT( SRCS WIN32
#   Util/src/WinRegistryConfiguration.cpp
#   Util/src/WinRegistryKey.cpp
#   Util/src/WinService.cpp
# )

#
# Get source from XML
#

# # Sources XML
# file(GLOB SRCS_G "XML/src/*.cpp")
# POCO_SOURCES_AUTO( SRCS ${SRCS_G})

# # Headers XML
# file(GLOB_RECURSE HDRS_G "XML/include/*.h" )
# POCO_HEADERS_AUTO( SRCS ${HDRS_G})

# POCO_SOURCES(SRCS expat
#   XML/src/xmlparse.cpp
#   XML/src/xmlrole.c
#   XML/src/xmltok.c
#   XML/src/xmltok_impl.c
#   XML/src/xmltok_ns.c)

#
# Get source from JSON
#

# # Sources JSON
# file(GLOB SRCS_G "JSON/src/*.cpp")
# POCO_SOURCES_AUTO( SRCS ${SRCS_G})
# POCO_SOURCES(SRCS pdjson JSON/src/pdjson.c)

# # Headers JSON
# file(GLOB_RECURSE HDRS_G "JSON/include/*.h" )
# POCO_HEADERS_AUTO( SRCS ${HDRS_G})

# Create static Library
add_library(Poco STATIC 
  ${SRCS})

# target_link_libraries(Poco
#   PRIVATE
#     warhead-default-interface
#     warhead-no-warning-interface)

if(WIN32)
target_link_libraries(Poco
  PRIVATE
    iphlpapi)
endif()

target_include_directories(Poco
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/Foundation/include
    # ${CMAKE_CURRENT_SOURCE_DIR}/Util/include
    # ${CMAKE_CURRENT_SOURCE_DIR}/JSON/include
    # ${CMAKE_CURRENT_SOURCE_DIR}/XML/include
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Foundation/src
    # ${CMAKE_CURRENT_SOURCE_DIR}/Util/src
    # ${CMAKE_CURRENT_SOURCE_DIR}/JSON/src
    # ${CMAKE_CURRENT_SOURCE_DIR}/XML/src
    )

target_compile_definitions(Poco
  PUBLIC
    POCO_STATIC
    # XML_DTD
  PRIVATE
    # xmltok_ns
    # HAVE_EXPAT_CONFIG_H
    )

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

# if(WIN32)
#   #TODO: Is XML_STATIC only required with Windows? What does it do?
#   target_compile_definitions(Poco 
#     PUBLIC
#       XML_STATIC)
# endif()

# if(MSVC)
#   set_property(TARGET Poco 
#     PROPERTY C_STANDARD 99)
# else()
#   target_compile_features(Poco
#     PUBLIC
#       c_variadic_macros)
# endif()

set_target_properties(Poco
  PROPERTIES
    DEFINE_SYMBOL Foundation_EXPORTS
    # DEFINE_SYMBOL Util_EXPORTS
    # DEFINE_SYMBOL JSON_EXPORTS
    # DEFINE_SYMBOL XML_EXPORTS
    )
