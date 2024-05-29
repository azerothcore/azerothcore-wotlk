#
# Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
# Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

set(SCRIPTS_AVAILABLE_OPTIONS none static dynamic minimal-static minimal-dynamic)
set(MODULES_AVAILABLE_OPTIONS none static dynamic)
set(BUILD_APPS_AVAILABLE_OPTIONS none all auth-only world-only)
set(BUILD_TOOLS_AVAILABLE_OPTIONS none all db-only maps-only)

set(SCRIPTS "static" CACHE STRING "Build core with scripts")
set(MODULES "static" CACHE STRING "Build core with modules")
set(APPS_BUILD "all" CACHE STRING "Build list for applications")
set(TOOLS_BUILD "none" CACHE STRING "Build list for tools")

set_property(CACHE SCRIPTS PROPERTY STRINGS ${SCRIPTS_AVAILABLE_OPTIONS})
set_property(CACHE MODULES PROPERTY STRINGS ${MODULES_AVAILABLE_OPTIONS})
set_property(CACHE APPS_BUILD PROPERTY STRINGS ${BUILD_APPS_AVAILABLE_OPTIONS})
set_property(CACHE TOOLS_BUILD PROPERTY STRINGS ${BUILD_TOOLS_AVAILABLE_OPTIONS})

# Log a error when the value of the SCRIPTS variable isn't a valid option.
if(SCRIPTS)
  list(FIND SCRIPTS_AVAILABLE_OPTIONS "${SCRIPTS}" SCRIPTS_INDEX)
  if(${SCRIPTS_INDEX} EQUAL -1)
    message(FATAL_ERROR "The value (${SCRIPTS}) of your SCRIPTS variable is invalid! "
            "Allowed values are: ${SCRIPTS_AVAILABLE_OPTIONS}. Set static")
  endif()
endif()

# Log a error when the value of the MODULES variable isn't a valid option.
if(MODULES)
  list(FIND MODULES_AVAILABLE_OPTIONS "${MODULES}" MODULES_INDEX)
  if(${MODULES_INDEX} EQUAL -1)
    message(FATAL_ERROR "The value (${MODULES}) of your MODULES variable is invalid! "
            "Allowed values are: ${MODULES_AVAILABLE_OPTIONS}. Set static")
  endif()
endif()

# Log a fatal error when the value of the APPS_BUILD variable isn't a valid option.
if(APPS_BUILD)
  list(FIND BUILD_APPS_AVAILABLE_OPTIONS "${APPS_BUILD}" BUILD_APPS_INDEX)
  if(${BUILD_APPS_INDEX} EQUAL -1)
    message(FATAL_ERROR "The value (${APPS_BUILD}) of your APPS_BUILD variable is invalid! "
                        "Allowed values are: ${BUILD_APPS_AVAILABLE_OPTIONS}. Set default")
  endif()
endif()

# Log a fatal error when the value of the TOOLS_BUILD variable isn't a valid option.
if(TOOLS_BUILD)
  list(FIND BUILD_TOOLS_AVAILABLE_OPTIONS "${TOOLS_BUILD}" BUILD_TOOLS_INDEX)
  if(${BUILD_TOOLS_INDEX} EQUAL -1)
    message(FATAL_ERROR "The value (${TOOLS_BUILD}) of your TOOLS_BUILD variable is invalid! "
                        "Allowed values are: ${BUILD_TOOLS_AVAILABLE_OPTIONS}. Set default")
  endif()
endif()

# Build a list of all script modules when -DSCRIPT="custom" is selected
GetScriptModuleList(SCRIPT_MODULE_LIST)
foreach(SCRIPT_MODULE ${SCRIPT_MODULE_LIST})
  ScriptModuleNameToVariable(${SCRIPT_MODULE} SCRIPT_MODULE_VARIABLE)
  set(${SCRIPT_MODULE_VARIABLE} "default" CACHE STRING "Build type of the ${SCRIPT_MODULE} module.")
  set_property(CACHE ${SCRIPT_MODULE_VARIABLE} PROPERTY STRINGS default disabled static dynamic)
endforeach()

# Build a list of all modules script when -DMODULE="custom" is selected
GetModuleSourceList(SCRIPT_MODULE_LIST)
foreach(SCRIPT_MODULE ${SCRIPT_MODULE_LIST})
  ModuleNameToVariable(${SCRIPT_MODULE} SCRIPT_MODULE_VARIABLE)
  set(${SCRIPT_MODULE_VARIABLE} "default" CACHE STRING "Build type of the ${SCRIPT_MODULE} module.")
  set_property(CACHE ${SCRIPT_MODULE_VARIABLE} PROPERTY STRINGS default disabled static dynamic)
endforeach()

# Build a list of all applications when -DBUILD_APPS="custom" is selected
GetApplicationsList(APPLICATIONS_BUILD_LIST)
foreach(APPLICATION_BUILD_NAME ${APPLICATIONS_BUILD_LIST})
  ApplicationNameToVariable(${APPLICATION_BUILD_NAME} APPLICATION_BUILD_VARIABLE)
  set(${APPLICATION_BUILD_VARIABLE} "default" CACHE STRING "Enable build the ${APPLICATION_BUILD_NAME} application.")
  set_property(CACHE ${APPLICATION_BUILD_VARIABLE} PROPERTY STRINGS default enabled disabled)
endforeach()

# Build a list of all applications when -DBUILD_TOOLS="custom" is selected
GetToolsList(TOOLS_BUILD_LIST)
foreach(TOOL_BUILD_NAME ${TOOLS_BUILD_LIST})
  ToolNameToVariable(${TOOL_BUILD_NAME} TOOL_BUILD_VARIABLE)
  set(${TOOL_BUILD_VARIABLE} "default" CACHE STRING "Enable build the ${TOOL_BUILD_NAME} tool.")
  set_property(CACHE ${TOOL_BUILD_VARIABLE} PROPERTY STRINGS default enabled disabled)
endforeach()

option(BUILD_TESTING       "Build unit tests"                                            0)
option(USE_SCRIPTPCH       "Use precompiled headers when compiling scripts"              1)
option(USE_COREPCH         "Use precompiled headers when compiling servers"              1)
option(WITH_WARNINGS       "Show all warnings during compile"                            0)
option(WITH_COREDEBUG      "Include additional debug-code in core"                       0)
option(WITH_PERFTOOLS      "Enable compilation with gperftools libraries included"       0)
option(WITHOUT_GIT         "Disable the GIT testing routines"                            0)
option(ENABLE_VMAP_CHECKS  "Enable Checks relative to DisableMgr system on vmap"         1)
option(WITH_DYNAMIC_LINKING "Enable dynamic library linking."                            0)
option(WITH_STRICT_DATABASE_TYPE_CHECKS "Enable strict checking of database field value accessors" 0)
option(WITHOUT_METRICS     "Disable metrics reporting (i.e. InfluxDB and Grafana)"       0)
option(WITH_DETAILED_METRICS  "Enable detailed metrics reporting (i.e. time each session takes to update)" 0)

CheckApplicationsBuildList()
CheckToolsBuildList()
IsDynamicLinkingRequired(WITH_DYNAMIC_LINKING_FORCED)
IsDynamicLinkingModulesRequired(WITH_DYNAMIC_LINKING_FORCED)

if(WITH_DYNAMIC_LINKING AND WITH_DYNAMIC_LINKING_FORCED)
  set(WITH_DYNAMIC_LINKING_FORCED OFF)
endif()

if(WITH_DYNAMIC_LINKING OR WITH_DYNAMIC_LINKING_FORCED)
  set(BUILD_SHARED_LIBS ON)
else()
  set(BUILD_SHARED_LIBS OFF)
endif()

# Source tree in IDE
set(WITH_SOURCE_TREE       "hierarchical" CACHE STRING "Build the source tree for IDE's.")
set_property(CACHE WITH_SOURCE_TREE PROPERTY STRINGS no flat hierarchical)

# Config abort
option(CONFIG_ABORT_INCORRECT_OPTIONS "Enable abort if core found incorrect option in config files" 0)
