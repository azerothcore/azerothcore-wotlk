#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
#

# Sources
file(GLOB SRCS_G "src/*.cpp")
POCO_SOURCES_AUTO( SRCS ${SRCS_G})

# Headers
file(GLOB_RECURSE HDRS_G "include/*.h" )
POCO_HEADERS_AUTO( SRCS ${HDRS_G})

POCO_SOURCES_AUTO_PLAT(SRCS WIN32
  src/WinRegistryConfiguration.cpp
  src/WinRegistryKey.cpp
  src/WinService.cpp)

add_library(Util ${SRCS} )
add_library(Poco::Util ALIAS Util)

target_link_libraries(Util PUBLIC Poco::Foundation)
target_compile_definitions(Util 
  PUBLIC 
    POCO_UTIL_NO_XMLCONFIGURATION
    POCO_UTIL_NO_JSONCONFIGURATION)

target_include_directories(Util
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
  PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}/src)
