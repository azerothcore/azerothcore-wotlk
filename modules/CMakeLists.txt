#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
#

if (NOT DISABLED_ALL_MODULES)
# Collect source files not disable modules
CU_SUBDIRLIST(sub_DIRS  "${CMAKE_SOURCE_DIR}/modules" FALSE FALSE)
FOREACH(subdir ${sub_DIRS})
  get_filename_component(MODULENAME ${subdir} NAME)
    
  if (NOT ";${DISABLED_AC_MODULES};" MATCHES ";${MODULENAME};")
    STRING(REGEX REPLACE "^${CMAKE_SOURCE_DIR}/" "" subdir_rel ${subdir}) 
    CollectSourceFiles(
      ${CMAKE_SOURCE_DIR}/${subdir_rel}/
      PRIVATE_SOURCES)

    set(MODULES_STAT_SRCS
      ${MODULES_STAT_SRCS}
      ${PRIVATE_SOURCES})
  endif()
ENDFOREACH()

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_library(modules-interface INTERFACE)

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES)

target_include_directories(modules-interface
  INTERFACE
    ${PUBLIC_INCLUDES})

target_link_libraries(modules-interface
  INTERFACE
    game-interface
    scripts-interface)

add_library(modules STATIC
  ${MODULES_STAT_SRCS})

target_include_directories(modules
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(modules
  PRIVATE
    modules-interface)
endif()

add_dependencies(modules revision.h)

set_target_properties(modules
  PROPERTIES
    FOLDER
      "modules")
