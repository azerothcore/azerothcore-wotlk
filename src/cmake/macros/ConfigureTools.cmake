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

set(BUILD_TOOLS_MAPS 0)
set(BUILD_TOOLS_DB_IMPORT 0)

# Returns the base path to the tools directory in the source directory
function(GetToolsBasePath variable)
  set(${variable} "${CMAKE_SOURCE_DIR}/src/tools" PARENT_SCOPE)
endfunction()

# Stores the absolut path of the given tool in the variable
function(GetPathToTool tool variable)
  GetToolsBasePath(TOOLS_BASE_PATH)
  set(${variable} "${TOOLS_BASE_PATH}/${tool}" PARENT_SCOPE)
endfunction()

# Stores the project name of the given tool in the variable
function(GetProjectNameOfToolName tool variable)
  string(TOLOWER "${tool}" GENERATED_NAME)
  set(${variable} "${GENERATED_NAME}" PARENT_SCOPE)
endfunction()

# Creates a list of all applications and stores it in the given variable.
function(GetToolsList variable)
  GetToolsBasePath(BASE_PATH)
  file(GLOB LOCALE_SOURCE_TOOL_LIST RELATIVE
    ${BASE_PATH}
    ${BASE_PATH}/*)

  set(${variable})

  foreach(SOURCE_TOOL ${LOCALE_SOURCE_TOOL_LIST})
    GetPathToTool(${SOURCE_TOOL} SOURCE_TOOL_PATH)
    if(IS_DIRECTORY ${SOURCE_TOOL_PATH})
      list(APPEND ${variable} ${SOURCE_TOOL})
    endif()
  endforeach()

  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

# Converts the given application name into it's
# variable name which holds the build type.
function(ToolNameToVariable application variable)
  string(TOUPPER ${application} ${variable})
  set(${variable} "TOOL_${${variable}}")
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(CheckToolsBuildList)
  GetToolsList(TOOLS_BUILD_LIST)

  if (TOOLS_BUILD STREQUAL "none")
    set(TOOLS_DEFAULT_BUILD "disabled")
  else()
    set(TOOLS_DEFAULT_BUILD "enabled")
  endif()

  # Sets BUILD_TOOLS_USE_WHITELIST
  # Sets BUILD_TOOLS_WHITELIST
  if (TOOLS_BUILD MATCHES "-only")
    set(BUILD_TOOLS_USE_WHITELIST ON)

    if (TOOLS_BUILD STREQUAL "maps-only")
      list(APPEND BUILD_TOOLS_WHITELIST map_extractor mmaps_generator vmap4_assembler vmap4_extractor)
    endif()

    # if (TOOLS_BUILD STREQUAL "db-only")
    #   list(APPEND BUILD_TOOLS_WHITELIST dbimport)
    # endif()
  endif()

  # Set the TOOL_${TOOL_BUILD_NAME} variables from the
  # variables set above
  foreach(TOOL_BUILD_NAME ${TOOLS_BUILD_LIST})
    ToolNameToVariable(${TOOL_BUILD_NAME} TOOL_BUILD_VARIABLE)

    if (${TOOL_BUILD_VARIABLE} STREQUAL "default")
      if (BUILD_TOOLS_USE_WHITELIST)
        list(FIND BUILD_TOOLS_WHITELIST "${TOOL_BUILD_NAME}" INDEX)
        if (${INDEX} GREATER -1)
          set(${TOOL_BUILD_VARIABLE} ${TOOLS_DEFAULT_BUILD})
        else()
          set(${TOOL_BUILD_VARIABLE} "disabled")
        endif()
      else()
        set(${TOOL_BUILD_VARIABLE} ${TOOLS_DEFAULT_BUILD})
      endif()
    endif()

    # Build the Graph values
    if (${TOOL_BUILD_VARIABLE} MATCHES "enabled")
      if (${TOOL_BUILD_NAME} MATCHES "dbimport")
        set(BUILD_TOOLS_DB_IMPORT 1 PARENT_SCOPE)
      else()
        set(BUILD_TOOLS_MAPS 1 PARENT_SCOPE)
      endif()
    endif()
  endforeach()
endfunction()
