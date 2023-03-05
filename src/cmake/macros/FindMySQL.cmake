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

#[==[
Provides the following variables:

  * `MYSQL_INCLUDE_DIRS`: Include directories necessary to use MySQL.
  * `MYSQL_LIBRARIES`: Libraries necessary to use MySQL.
  * A `MySQL::MySQL` imported target.
#]==]

# Set allowed MySQL and MariaDB versions
set(_MySQL_mariadb_versions 10.5 10.6)
set(_MySQL_versions 5.7 8.0)

# Set Min allowed MySQL and MariaDB versions
set(_MySQL_mariadb_min_version 10.5)
set(_MySQL_min_version 5.7)

# Set Max allowed MySQL and MariaDB versions
set(_MySQL_mariadb_max_version 10.6)
set(_MySQL_max_version 8.0)

# No .pc files are shipped with MySQL on Windows.
set(_MySQL_use_pkgconfig 0)
if (NOT WIN32)
  find_package(PkgConfig)
  if (PkgConfig_FOUND)
    set(_MySQL_use_pkgconfig 1)
  endif ()
endif ()

if (_MySQL_use_pkgconfig)
  pkg_check_modules(_libmariadb "libmariadb" QUIET IMPORTED_TARGET)
  unset(_mysql_target)
  if (_libmariadb_FOUND)
    set(_mysql_target "_libmariadb")
  else ()
    pkg_check_modules(_mariadb "mariadb" QUIET IMPORTED_TARGET)
    if (NOT _mariadb_FOUND)
      pkg_check_modules(_mysql "mysql" QUIET IMPORTED_TARGET)
      if (_mysql_FOUND)
        set(_mysql_target "_mysql")
      endif ()
    else ()
      set(_mysql_target "_mariadb")
    endif ()
  endif ()

  set(MySQL_FOUND 0)
  if (_mysql_target)
    set(MySQL_FOUND 1)
    set(MYSQL_INCLUDE_DIRS ${${_mysql_target}_INCLUDE_DIRS})
    set(MYSQL_LIBRARIES ${${_mysql_target}_LINK_LIBRARIES})
    if (NOT TARGET MySQL::MySQL)
      add_library(MySQL::MySQL INTERFACE IMPORTED)
      target_link_libraries(MySQL::MySQL
        INTERFACE "PkgConfig::${_mysql_target}")
    endif ()
  endif ()

  unset(_mysql_target)
else ()
  set(_MySQL_paths)
  foreach (_MySQL_version IN LISTS _MySQL_mariadb_versions)
    list(APPEND _MySQL_paths
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MariaDB ${_MySQL_version};INSTALLDIR]"
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MariaDB ${_MySQL_version} (x64);INSTALLDIR]")
  endforeach ()
  foreach (_MySQL_version IN LISTS _MySQL_versions)
    list(APPEND _MySQL_paths
      "C:/Program Files/MySQL/MySQL Server ${_MySQL_version}/lib/opt"
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MySQL AB\\MySQL Server ${_MySQL_version};Location]"
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\MySQL AB\\MySQL Server ${_MySQL_version};Location]")
  endforeach ()
  unset(_MySQL_version)

  find_path(MySQL_INCLUDE_DIR
    NAMES mysql.h
    PATHS
      "C:/Program Files/MySQL/include"
      "C:/MySQL/include"
      ${_MySQL_paths}
    PATH_SUFFIXES include include/mysql
    DOC "Location of mysql.h")
  mark_as_advanced(MySQL_INCLUDE_DIR)
  find_library(MySQL_LIBRARY
    NAMES libmariadb mysql libmysql mysqlclient
    PATHS
      "C:/Program Files/MySQL/lib"
      "C:/MySQL/lib/debug"
      ${_MySQL_paths}
    PATH_SUFFIXES lib lib/opt
    DOC "Location of the mysql library")
  mark_as_advanced(MySQL_LIBRARY)

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(MySQL
    REQUIRED_VARS MySQL_INCLUDE_DIR MySQL_LIBRARY)

  if (MySQL_FOUND)
    set(MYSQL_INCLUDE_DIRS "${MySQL_INCLUDE_DIR}")
    set(MYSQL_LIBRARIES "${MySQL_LIBRARY}")
    if (NOT TARGET MySQL::MySQL)
      add_library(MySQL::MySQL UNKNOWN IMPORTED)
      set_target_properties(MySQL::MySQL PROPERTIES
      IMPORTED_LOCATION "${MySQL_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${MySQL_INCLUDE_DIR}")
    endif ()
  endif ()
endif ()

if (_libmariadb_FOUND)
  if (_mariadb_VERSION VERSION_LESS _MySQL_mariadb_min_version OR _mariadb_VERSION VERSION_GREATER _MySQL_mariadb_max_version)
    message(FATAL_ERROR "Using unsupported MariaDB version! Supported versions ${_MySQL_mariadb_versions}")
  endif ()
endif ()

if (_mysql_FOUND)
  if (_mysql_version VERSION_LESS _MySQL_min_version OR _mysql_version VERSION_GREATER _MySQL_max_version)
    message(FATAL_ERROR "Using unsupported MySQL version! Supported versions ${_MySQL_versions}")
  endif ()
endif ()

unset(_MySQL_use_pkgconfig)
unset(_MySQL_versions)
unset(_MySQL_mariadb_versions)
unset(_MySQL_mariadb_min_version)
unset(_MySQL_mariadb_max_version)
unset(_MySQL_min_version)
unset(_MySQL_max_version)
