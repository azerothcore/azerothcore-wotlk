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

add_library(httplib INTERFACE)

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES)

target_include_directories(httplib
  INTERFACE
    ${PUBLIC_INCLUDES}})

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(httplib
  PRIVATE
    acore-dependency-interface)
    
target_compile_definitions(httplib
  INTERFACE
    -DCPPHTTPLIB_OPENSSL_SUPPORT)

set_target_properties(httplib
  PROPERTIES
    FOLDER
      "deps")
