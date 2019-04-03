# Copyright (C)
# Copyright (C)
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

CollectSourceFiles(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE_SOURCES)

add_executable(MeshExtractor ${PRIVATE_SOURCES})

target_link_libraries(MeshExtractor
  PUBLIC
    common
    Recast
    mpq)

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES)

target_include_directories(MeshExtractor
  PUBLIC
    ${PUBLIC_INCLUDES}
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

set_target_properties(MeshExtractor
  PROPERTIES
    FOLDER
      "tools")

if( UNIX )
  install(TARGETS MeshExtractor DESTINATION bin)
elseif( WIN32 )
  install(TARGETS MeshExtractor DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif()
