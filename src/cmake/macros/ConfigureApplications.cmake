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

set(BUILD_APPLICATION_AUTHSERVER 0)
set(BUILD_APPLICATION_WORLDSERVER 0)

# Returns the base path to the apps directory in the source directory
function(GetApplicationsBasePath variable)
  set(${variable} "${CMAKE_SOURCE_DIR}/src/server/apps" PARENT_SCOPE)
endfunction()

# Stores the absolut path of the given app in the variable
function(GetPathToApplication app variable)
  GetApplicationsBasePath(APPS_BASE_PATH)
  set(${variable} "${APPS_BASE_PATH}/${app}" PARENT_SCOPE)
endfunction()

# Stores the project name of the given app in the variable
function(GetProjectNameOfApplicationName app variable)
  string(TOLOWER "${app}" GENERATED_NAME)
  set(${variable} "${GENERATED_NAME}" PARENT_SCOPE)
endfunction()

# Creates a list of all applications and stores it in the given variable.
function(GetApplicationsList variable)
  GetApplicationsBasePath(BASE_PATH)
  file(GLOB LOCALE_SOURCE_APP_LIST RELATIVE
    ${BASE_PATH}
    ${BASE_PATH}/*)

  set(${variable})

  foreach(SOURCE_APP ${LOCALE_SOURCE_APP_LIST})
    GetPathToApplication(${SOURCE_APP} SOURCE_APP_PATH)
    if(IS_DIRECTORY ${SOURCE_APP_PATH})
      list(APPEND ${variable} ${SOURCE_APP})
    endif()
  endforeach()

  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

# Converts the given application name into it's
# variable name which holds the build type.
function(ApplicationNameToVariable application variable)
  string(TOUPPER ${application} ${variable})
  set(${variable} "APP_${${variable}}")
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(CheckApplicationsBuildList)
  GetApplicationsList(APPLICATIONS_BUILD_LIST)

  if (APPS_BUILD STREQUAL "none")
    set(APPS_DEFAULT_BUILD "disabled")
  else()
    set(APPS_DEFAULT_BUILD "enabled")
  endif()

  # Sets BUILD_APPS_USE_WHITELIST
  # Sets BUILD_APPS_WHITELIST
  if (APPS_BUILD MATCHES "-only")
    set(BUILD_APPS_USE_WHITELIST ON)

    if (APPS_BUILD STREQUAL "auth-only")
      list(APPEND BUILD_APPS_WHITELIST authserver)
    endif()

    if (APPS_BUILD STREQUAL "world-only")
      list(APPEND BUILD_APPS_WHITELIST worldserver)
    endif()
  endif()

  foreach(APPLICATION_BUILD_NAME ${APPLICATIONS_BUILD_LIST})
    ApplicationNameToVariable(${APPLICATION_BUILD_NAME} APPLICATION_BUILD_VARIABLE)

    if(${APPLICATION_BUILD_VARIABLE} STREQUAL "default")
      if(BUILD_APPS_USE_WHITELIST)
        list(FIND BUILD_APPS_WHITELIST "${APPLICATION_BUILD_NAME}" INDEX)
        if(${INDEX} GREATER -1)
          set(${APPLICATION_BUILD_VARIABLE} ${APPS_DEFAULT_BUILD})
        else()
          set(${APPLICATION_BUILD_VARIABLE} "disabled")
        endif()
      else()
        set(${APPLICATION_BUILD_VARIABLE} ${APPS_DEFAULT_BUILD})
      endif()
    endif()

    # Build the Graph values
    if(${APPLICATION_BUILD_VARIABLE} MATCHES "enabled")
      if (${APPLICATION_BUILD_NAME} MATCHES "authserver")
        set (BUILD_APPLICATION_AUTHSERVER 1 PARENT_SCOPE)
      elseif(${APPLICATION_BUILD_NAME} MATCHES "worldserver")
        set (BUILD_APPLICATION_WORLDSERVER 1 PARENT_SCOPE)
      endif()
    endif()
  endforeach()
endfunction()
