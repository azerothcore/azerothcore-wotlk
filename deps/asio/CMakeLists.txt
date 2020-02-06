#
# Copyright (C)
#

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  PUBLIC_INCLUDES)

# Create interface Library
add_library(asio INTERFACE)

target_include_directories(asio
  INTERFACE
    ${PUBLIC_INCLUDES})

target_link_libraries(asio
  INTERFACE
    acore-dependency-interface)

target_compile_definitions(asio INTERFACE ASIO_STANDALONE)
