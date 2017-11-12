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
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/recastnavigation/Detour
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/recastnavigation/Recast
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/g3dlite/include
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/SFMT
  ${CMAKE_SOURCE_DIR}/modules/worldengine/deps/zlib
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Management
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Models
  ${CMAKE_SOURCE_DIR}/modules/worldengine/lib-collision/src/Maps
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Configuration
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Cryptography
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Cryptography/Authentication
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Database
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/DataStores
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Debugging
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Dynamic/LinkedReference
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Dynamic
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Logging
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Packets
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Threading
  ${CMAKE_SOURCE_DIR}/modules/worldengine/nucleus/src/Utilities
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
