# Copyright (C)
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# Enable precompiled headers when using the GCC compiler.

CU_RUN_HOOK(BEFORE_SCRIPTS_LIBRARY)

CU_SET_PATH("AC_SCRIPTS_DIR" "${CMAKE_CURRENT_LIST_DIR}")

message(STATUS "SCRIPT PREPARATIONS")

include(Spells/CMakeLists.txt)
include(Commands/CMakeLists.txt)

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ScriptLoader.cpp
  ScriptLoader.h
  ${BUILDDIR}/GenLoader.cpp
  ../game/AI/ScriptedAI/ScriptedEscortAI.cpp
  ../game/AI/ScriptedAI/ScriptedCreature.cpp
  ../game/AI/ScriptedAI/ScriptedFollowerAI.cpp
)

AC_ADD_SCRIPT_LOADER("Spell" "ScriptLoader.h")
AC_ADD_SCRIPT_LOADER("SC_Smart" "ScriptLoader.h")
AC_ADD_SCRIPT_LOADER("Command" "ScriptLoader.h")

CU_SET_PATH("CMAKE_AC_MODULE_DIR" "${CMAKE_CURRENT_LIST_DIR}")

if(SCRIPTS)
  include(World/CMakeLists.txt)
  include(OutdoorPvP/CMakeLists.txt)
  include(EasternKingdoms/CMakeLists.txt)
  include(Kalimdor/CMakeLists.txt)
  include(Outland/CMakeLists.txt)
  include(Northrend/CMakeLists.txt)
  include(Events/CMakeLists.txt)
  include(Pet/CMakeLists.txt)
endif()

if(EXISTS "${AC_SCRIPTS_DIR}/Custom/CMakeLists.txt")
include(Custom/CMakeLists.txt)
endif()

CU_GET_GLOBAL("AC_ADD_SCRIPTS_LIST")
CU_GET_GLOBAL("AC_ADD_SCRIPTS_INCLUDE")
CU_GET_GLOBAL("AC_SCRIPTS_SOURCES")

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${AC_SCRIPTS_SOURCES}
)

set("AC_SCRIPTS_INCLUDES" "")

FOREACH (include ${AC_ADD_SCRIPTS_INCLUDE})
    set("AC_SCRIPTS_INCLUDES" "#include \"${include}\"\n${AC_SCRIPTS_INCLUDES}")
ENDFOREACH()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/GenLoader.cpp.cmake ${BUILDDIR}/GenLoader.cpp)

message(STATUS "SCRIPT PREPARATION COMPLETE")
message("")

if (USE_SCRIPTPCH)
  set(PRIVATE_PCH_HEADER PrecompiledHeaders/ScriptPCH.h)
endif ()

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_library(scripts-interface INTERFACE)

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES
  # Exclude
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders)

target_include_directories(scripts-interface
  INTERFACE
    ${PUBLIC_INCLUDES})

target_link_libraries(scripts-interface
  INTERFACE
    common)

add_library(scripts STATIC
  ${scripts_STAT_SRCS}
)

target_include_directories(scripts
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(scripts
  PRIVATE
    scripts-interface
    game-interface)

set_target_properties(scripts
  PROPERTIES
    FOLDER
      "server")

add_dependencies(scripts revision.h)

# Generate precompiled header
if (USE_SCRIPTPCH)
  add_cxx_pch(scripts ${PRIVATE_PCH_HEADER})
endif()
