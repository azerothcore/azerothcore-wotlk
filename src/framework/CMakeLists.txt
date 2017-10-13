if( USE_COREPCH )
  include_directories(${CMAKE_CURRENT_BINARY_DIR})
endif()

file(GLOB_RECURSE sources_Addons Addons/*.cpp Addons/*.h)
file(GLOB sources_localdir *.cpp *.h)

# Build gamefw sourcelist
#

if (USE_COREPCH)
  set(gamefw_STAT_PCH_HDR PrecompiledHeaders/gamefwPCH.h)
  set(gamefw_STAT_PCH_SRC PrecompiledHeaders/gamefwPCH.cpp)
endif()

set(gamefw_STAT_SRCS
  ${gamefw_STAT_SRCS}
  ${sources_Addons}
  ${sources_localdir}
)

include_directories(
  ${CMAKE_BINARY_DIR}
  ${CMAKE_SOURCE_DIR}/deps/recastnavigation/Detour
  ${CMAKE_SOURCE_DIR}/deps/recastnavigation/Recast
  ${CMAKE_SOURCE_DIR}/deps/g3dlite/include
  ${CMAKE_SOURCE_DIR}/deps/SFMT
  ${CMAKE_SOURCE_DIR}/deps/zlib
  ${CMAKE_SOURCE_DIR}/src/libraries/collision/
  ${CMAKE_SOURCE_DIR}/src/libraries/collision/Management
  ${CMAKE_SOURCE_DIR}/src/libraries/collision/Models
  ${CMAKE_SOURCE_DIR}/src/libraries/collision/Maps
  ${CMAKE_SOURCE_DIR}/src/core
  ${CMAKE_SOURCE_DIR}/src/core/Configuration
  ${CMAKE_SOURCE_DIR}/src/core/Cryptography
  ${CMAKE_SOURCE_DIR}/src/core/Cryptography/Authentication
  ${CMAKE_SOURCE_DIR}/src/core/Database
  ${CMAKE_SOURCE_DIR}/src/core/DataStores
  ${CMAKE_SOURCE_DIR}/src/core/Debugging
  ${CMAKE_SOURCE_DIR}/src/core/Dynamic/LinkedReference
  ${CMAKE_SOURCE_DIR}/src/core/Dynamic
  ${CMAKE_SOURCE_DIR}/src/core/Logging
  ${CMAKE_SOURCE_DIR}/src/core/Packets
  ${CMAKE_SOURCE_DIR}/src/core/Threading
  ${CMAKE_SOURCE_DIR}/src/core/Utilities
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/Addons
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}
  ${OPENSSL_INCLUDE_DIR}
)

add_library(gamefw STATIC
  ${gamefw_STAT_SRCS}
  ${gamefw_STAT_PCH_SRC}
)

target_link_libraries(gamefw
  ${ACE_LIBRARY}
)

# Generate precompiled header
if (USE_COREPCH)
  add_cxx_pch(gamefw ${gamefw_STAT_PCH_HDR} ${gamefw_STAT_PCH_SRC})
endif ()
