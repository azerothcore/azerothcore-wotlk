
set(BUILD_TOOLS_EVERDAWN 0)

# Stores the absolut path of the given tool in the variable
function(GetPathToEverdawnTool tool variable)
  GetToolsBasePath(TOOLS_BASE_PATH)
  set(TOOLS_BASE_PATH ${TOOLS_BASE_PATH}/everdawn)
  set(${variable} "${TOOLS_BASE_PATH}/${tool}" PARENT_SCOPE)
endfunction()

# Creates a list of all applications and stores it in the given variable.
function(GetEverdawnToolsList variable)
  GetToolsBasePath(BASE_PATH)
  set(BASE_PATH ${BASE_PATH}/everdawn)
  file(GLOB LOCALE_SOURCE_TOOL_LIST RELATIVE
    ${BASE_PATH}
    ${BASE_PATH}/*)

  set(${variable})

  foreach(SOURCE_TOOL ${LOCALE_SOURCE_TOOL_LIST})
    GetPathToEverdawnTool(${SOURCE_TOOL} SOURCE_TOOL_PATH)
    if(IS_DIRECTORY ${SOURCE_TOOL_PATH})
      list(APPEND ${variable} ${SOURCE_TOOL})
    endif()
  endforeach()

  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(CheckEverdawnToolsBuildList)
  GetEverdawnToolsList(TOOLS_BUILD_LIST)

  if (TOOLS_BUILD STREQUAL "none")
    return()
  endif()

  # Sets BUILD_TOOLS_USE_WHITELIST
  # Sets BUILD_TOOLS_WHITELIST
  if ((TOOLS_BUILD STREQUAL "everdawn-only") OR (TOOLS_BUILD STREQUAL "all"))
    set(BUILD_TOOLS_USE_WHITELIST ON)
    list(APPEND BUILD_TOOLS_WHITELIST everdawn)
    set(BUILD_TOOLS_EVERDAWN 1 PARENT_SCOPE)
  endif()

endfunction()
