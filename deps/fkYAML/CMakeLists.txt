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

add_library(fkYAML INTERFACE)

target_include_directories(fkYAML INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

set_target_properties(fkYAML PROPERTIES FOLDER "deps")
