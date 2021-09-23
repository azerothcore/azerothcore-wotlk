#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
#

add_library(gperftools INTERFACE)

target_link_libraries(gperftools
  INTERFACE
    ${GPERFTOOLS_LIBRARIES})
